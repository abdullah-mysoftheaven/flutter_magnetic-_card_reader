package com.example.smartposplugin;

import android.content.Context;
import android.util.Log;

import com.zcs.sdk.DriverManager;
import com.zcs.sdk.SdkResult;
import com.zcs.sdk.card.CardReaderManager;
import com.zcs.sdk.card.CardReaderTypeEnum;
import com.zcs.sdk.card.CardSlotNoEnum;
import com.zcs.sdk.card.ICCard;
import com.zcs.sdk.card.MagCard;
import com.zcs.sdk.card.RfCard;
import com.zcs.sdk.emv.EmvApp;
import com.zcs.sdk.emv.EmvCapk;
import com.zcs.sdk.emv.EmvData;
import com.zcs.sdk.emv.EmvHandler;
import com.zcs.sdk.emv.EmvResult;
import com.zcs.sdk.emv.EmvTermParam;
import com.zcs.sdk.emv.EmvTransParam;
import com.zcs.sdk.emv.OnEmvListener;
import com.zcs.sdk.pin.PinAlgorithmMode;
import com.zcs.sdk.pin.pinpad.PinPadManager;
import com.zcs.sdk.util.StringUtils;

import java.io.File;
import java.io.IOException;
import java.lang.reflect.Method;
import java.util.concurrent.CountDownLatch;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.plugin.common.MethodChannel;

public class EmvImple
{
    private DriverManager mDriverManager = DriverManager.getInstance();
    private EmvHandler emvHandler;
    private CardReaderManager mCardReadManager;
    private ICCard mICCard;
    private MagCard mMAGCard;
    private RfCard mRFCard;
    private PinPadManager mPinPadManager;
    private  Context context;
    private byte emvRestlut;
    private int iRet;
    CountDownLatch mLatch;
    CountDownLatch mLatch1;
    private int inputPINResult = 0x00;
    CardReaderTypeEnum realCardType;
    private byte[] mPinBlock = new byte[12 + 1];
    final EmvTermParam emvTermParam = new EmvTermParam();
    public EmvTransParam emvTransParam = new EmvTransParam();
    private static EmvImple instance;


    public void setReturnCode(int iret){

        iRet=iret;

    }



    private EmvImple(){

    }

    public static EmvImple getInstance() {
        if (instance == null) {
            instance = new EmvImple();
        }
        return instance;
    }

    public int EmvInit(Context mcontext){

        mCardReadManager = mDriverManager.getCardReadManager();

        emvHandler = EmvHandler.getInstance();
        mICCard = mCardReadManager.getICCard();
        mMAGCard = mCardReadManager.getMAGCard();
        mRFCard = mCardReadManager.getRFCard();
        mPinPadManager = mDriverManager.getPadManager();
        context=mcontext;

        // 1. copy aid and capk to '/sdcard/emv/' as the default aid and capk
        try {
            if (!new File(EmvTermParam.emvParamFilePath).exists()) {
                FileUtils.doCopy(context, "emv", EmvTermParam.emvParamFilePath);

            }
        } catch (IOException e) {
            e.printStackTrace();
        }


        emvHandler.kernelInit(emvTermParam);

        return 0;

    }

    /**
     * To use the pin pad, you must register the activity for pin. Plz refer to the lib doc.
     *
     * @param pinType
     * @return
     */
    private int inputPIN(byte pinType) {
        final byte InputPinType = pinType;
        mLatch = new CountDownLatch(1);

        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    PinPadManager.OnPinPadInputListener onPinPadInputListener = new PinPadManager.OnPinPadInputListener() {

                        @Override
                        public void onSuccess(byte[] pinBlock) {
                            System.arraycopy(pinBlock, 0, mPinBlock, 0, pinBlock.length);
                            mPinBlock[pinBlock.length] = 0x00;

                            String encryptedPin = emvHandler.bytesToHexString(mPinBlock);
                            Log.d("Debug", "encryptedPin=" + encryptedPin);

                            if (encryptedPin.length() == 0) {
                                inputPINResult = EmvResult.EMV_NO_PASSWORD;
                            } else {// pin length =0
                                inputPINResult = EmvResult.EMV_OK;
                            }
                            mLatch.countDown();
                        }

                        @Override
                        public void onError(int backCode) {
                            Log.d("Debug", "backCode=" + backCode);
                            if (backCode == SdkResult.SDK_PAD_ERR_NOPIN) {
                                inputPINResult = EmvResult.EMV_NO_PASSWORD;
                            } else if (backCode == SdkResult.SDK_PAD_ERR_TIMEOUT) {
                                inputPINResult = EmvResult.EMV_TIME_OUT;
                            } else if (backCode == SdkResult.SDK_PAD_ERR_CANCEL) {
                                inputPINResult = EmvResult.EMV_USER_CANCEL;
                            } else {
                                inputPINResult = EmvResult.EMV_NO_PINPAD_OR_ERR;
                            }

                           mLatch.countDown();
                        }
                    };

                    Log.d("Debug", "InputPinType=" + InputPinType);
                    if (InputPinType == EmvData.ONLINE_ENCIPHERED_PIN) {
                        String track2[] = new String[1];
                        String pan[] = new String[1];
                        iRet = emvHandler.getTrack2AndPAN(track2, pan);
                        mPinPadManager.inputOnlinePin(context, (byte) 4, (byte) 12, 60, true, pan[0], (byte) 0, PinAlgorithmMode.ANSI_X_9_8, onPinPadInputListener);
                    } else {
                        mPinPadManager.inputOfflinePin(context, (byte) 4, (byte) 12, 60, true, onPinPadInputListener);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }).start();
        try {
            mLatch.await();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return inputPINResult;
    }

    public int  addCapk(EmvCapk ec) {

       int ret= emvHandler.addCapk(ec);

       return ret;

    }

    public int  addApp(EmvApp ea) {

        int ret= emvHandler.addApp(ea);
        return ret;
    }

    public void  delAllCapk(){

        emvHandler.delAllCapk();

    }

    public void delAllApp(){

        emvHandler.delAllApp();
    }


    public  void MessageOnCall(String fun,String mesage){

        Log.d("Debug","MessageOnCall1");

        try {
            // 获取要调用的类的Class对象
            Class<?> cls = Class.forName("com.example.smartposplugin.SmartpospluginPlugin");

            // 创建类的实例
            Object obj = cls.newInstance();

            // 获取要调用的方法
            Method method = cls.getMethod("sendMessageToFultter", String.class,String.class);

            // 调用方法
            method.invoke(obj, fun,mesage);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    public int emv(int cardType) {

        if (cardType == 0) {
            realCardType=CardReaderTypeEnum.IC_CARD;

            emvTransParam.setTransKernalType(EmvData.KERNAL_EMV_PBOC);
        } else if (cardType == 1) {
            realCardType = CardReaderTypeEnum.RF_CARD;
            emvTransParam.setTransKernalType(EmvData.KERNAL_CONTACTLESS_ENTRY_POINT);
        }

        emvHandler.transParamInit(emvTransParam);
        emvHandler.kernelInit(emvTermParam);

        // 4. transaction
        byte[] pucIsEcTrans = new byte[1];
        byte[] pucBalance = new byte[6];
        byte[] pucTransResult = new byte[1];

        OnEmvListener onEmvListener = new OnEmvListener() {
            @Override
            public int onSelApp(String[] appLabelList) {
                Log.d("Debug", "onSelApp");

                String applistStr="";
                for(String str:appLabelList){

                    applistStr+=str+";";
                }

                MessageOnCall("onSelApp", "appLabelList:" +  applistStr);

                return iRet;
            }

            @Override
            public int onConfirmCardNo(String cardNo) {
                Log.d("Debug", "onConfirmCardNo");
                String[] track2 = new String[1];
                final String[] pan = new String[1];
                emvHandler.getTrack2AndPAN(track2, pan);
                int index = 0;
                if (track2[0].contains("D")) {
                    index = track2[0].indexOf("D") + 1;
                } else if (track2[0].contains("=")) {
                    index = track2[0].indexOf("=") + 1;
                }
                final String exp = track2[0].substring(index, index + 4);
                showLog("cardNum:" + pan[0]);
                showLog("exp:" + exp);

                MessageOnCall("onConfirmCardNo", "cardNo:" +  pan[0]+";"+"expireDate:"+exp);
                return iRet;
            }

            @Override
            public int onInputPIN(byte pinType) {
                // 1. open the secret pin pad to get pin block
                // 2. send the pinBlock to emv kernel
                if (emvTransParam.getTransKernalType() == EmvData.KERNAL_CONTACTLESS_ENTRY_POINT) {
                    String[] track2 = new String[1];
                    final String[] pan = new String[1];
                    emvHandler.getTrack2AndPAN(track2, pan);
                    int index = 0;
                    if (track2[0].contains("D")) {
                        index = track2[0].indexOf("D") + 1;
                    } else if (track2[0].contains("=")) {
                        index = track2[0].indexOf("=") + 1;
                    }
                    final String exp = track2[0].substring(index, index + 4);
                    showLog("card:" + pan[0]);
                    showLog("exp:" + exp);
                }
                Log.d("Debug", "onInputPIN");


                int iRet = 0;
                iRet = inputPIN(pinType);
                Log.d("Debug", "iRet=" + iRet);
                if (iRet == EmvResult.EMV_OK) {
                    emvHandler.setPinBlock(mPinBlock);
                }

              //  byte[] outPinBlock = new byte[12 + 1];
                String encryptedPinblock="";
                if(pinType==0) {

                    encryptedPinblock = emvHandler.bytesToHexString(mPinBlock);
                }
                MessageOnCall("onInputPIN", "inputPINResult:" + inputPINResult+";"+"pinblock:"+encryptedPinblock);


                return iRet;
            }

            @Override
            public int onCertVerify(int certType, String certNo) {
                Log.d("Debug", "onCertVerify");

                MessageOnCall("onCertVerify", "certType:" + certType+";"+"certNo:"+certNo);

                return iRet;
            }

            @Override
            public byte[] onExchangeApdu(byte[] send) {
                Log.d("Debug", "onExchangeApdu");

                if (realCardType == CardReaderTypeEnum.IC_CARD) {
                    return mICCard.icExchangeAPDU(CardSlotNoEnum.SDK_ICC_USERCARD, send);
                } else if (realCardType == CardReaderTypeEnum.RF_CARD) {
                    return mRFCard.rfExchangeAPDU(send);
                }

                return null;
            }

            @Override
            public int onlineProc() {
                // 1. assemble the authorisation request data and send to bank by using get 'emvHandler.getTlvData()'
                // 2. separateOnlineResp to emv kernel
                // 3. return the callback ret
                Log.d("Debug", "onOnlineProc");
//                byte[] authRespCode = new byte[3];
//                byte[] issuerResp = new byte[512];
//                int[] issuerRespLen = new int[1];
//                int iSendRet = emvHandler.separateOnlineResp(authRespCode, issuerResp, issuerRespLen[0]);
//                Log.d("Debug", "separateOnlineResp iSendRet=" + iSendRet);


                MessageOnCall("onlineProc","separateOnlineResp");

                Log.d("Debug", "onOnlineProc end");

                return iRet;
            }

        };
        showLog("Emv Trans start...");
        // for the emv result, plz refer to emv doc.
        int ret = emvHandler.emvTrans(emvTransParam, onEmvListener, pucIsEcTrans, pucBalance, pucTransResult);
        showLog("Emv trans end, ret = " + ret);
        String str = "Decline";
        if (pucTransResult[0] == EmvData.APPROVE_M) {
            str = "Approve";
        } else if (pucTransResult[0] == EmvData.ONLINE_M) {
            str = "Online";
        } else if (pucTransResult[0] == EmvData.DECLINE_M) {
            str = "Decline";
        }
        showLog("Emv trans result = " + pucTransResult[0] + ", " + str);

        emvRestlut=pucTransResult[0];

        return ret;

    }



    public int separateOnlineResp(byte[] authRespCode,byte[] issuerResp,int issuerRespLen){

        int iSendRet = emvHandler.separateOnlineResp(authRespCode, issuerResp, issuerRespLen);
        return iSendRet;
    }

    int[] tags = {
            0x9F26,
            0x9F27,
            0x9F10,
            0x9F37,
            0x9F36,
            0x95,
            0x9A,
            0x9C,
            0x9F02,
            0x5F2A,
            0x82,
            0x9F1A,
            0x9F03,
            0x9F33,
            0x9F34,
            0x9F35,
            0x9F1E,
            0x84,
            0x9F09,
            0x9F41,
            0x9F63,
            0x5F24
    };

    public String getEmvData() {


        byte[] field55 = emvHandler.packageTlvList(tags);
        //showLog("Filed55: " + StringUtils.convertBytesToHex(field55));
        return StringUtils.convertBytesToHex(field55);
    }

    public byte getEmvTransResult(){

        return emvRestlut;
    }



    public String getPinBlock(){

      return EmvHandler.getInstance().bytesToHexString(mPinBlock);

    }

    public int callOnlinePinPad(Context context,String pan){

        if(mPinPadManager==null)
        mPinPadManager = mDriverManager.getPadManager();

        mLatch1 = new CountDownLatch(1);

        new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    PinPadManager.OnPinPadInputListener onPinPadInputListener = new PinPadManager.OnPinPadInputListener() {

                        @Override
                        public void onSuccess(byte[] pinBlock) {
                            System.arraycopy(pinBlock, 0, mPinBlock, 0, pinBlock.length);
                            mPinBlock[pinBlock.length] = 0x00;

                            String encryptedPin =  EmvHandler.getInstance().bytesToHexString(mPinBlock);
                            Log.d("Debug", "encryptedPin=" + encryptedPin);

                            if (encryptedPin.length() == 0) {
                                inputPINResult = EmvResult.EMV_NO_PASSWORD;
                            } else {// pin length =0
                                inputPINResult = EmvResult.EMV_OK;
                            }

                          //  MessageOnCall("onInputPIN", "inputPINResult:" + inputPINResult+";"+"pinblock:"+encryptedPinblock);
                            mLatch1.countDown();
                        }

                        @Override
                        public void onError(int backCode) {
                            Log.d("Debug", "backCode=" + backCode);
                            if (backCode == SdkResult.SDK_PAD_ERR_NOPIN) {
                                inputPINResult = EmvResult.EMV_NO_PASSWORD;
                            } else if (backCode == SdkResult.SDK_PAD_ERR_TIMEOUT) {
                                inputPINResult = EmvResult.EMV_TIME_OUT;
                            } else if (backCode == SdkResult.SDK_PAD_ERR_CANCEL) {
                                inputPINResult = EmvResult.EMV_USER_CANCEL;
                            } else {
                                inputPINResult = EmvResult.EMV_NO_PINPAD_OR_ERR;
                            }

                            mLatch1.countDown();
                        }
                    };

                    mPinPadManager.inputOnlinePin(context, (byte) 4, (byte) 12, 60, true, pan, (byte) 0, PinAlgorithmMode.ANSI_X_9_8, onPinPadInputListener);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }).start();

        try {
            mLatch1.await();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        return inputPINResult;

    }


    public void showLog(final String log) {

        Log.d("Debug",log);

    }





}
