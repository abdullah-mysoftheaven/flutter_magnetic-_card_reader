package com.example.smartposplugin;

import android.app.Activity;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.graphics.drawable.Drawable;
import android.os.Handler;
import android.os.Looper;
import android.text.Layout;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.UiThread;

import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import com.zcs.sdk.DriverManager;
import com.zcs.sdk.Printer;
import com.zcs.sdk.SdkData;
import com.zcs.sdk.Sys;
import com.zcs.sdk.card.CardInfoEntity;
import com.zcs.sdk.card.CardReaderManager;
import com.zcs.sdk.card.CardSlotNoEnum;
import com.zcs.sdk.card.ICCard;
import com.zcs.sdk.card.MagCard;
import com.zcs.sdk.card.RfCard;
import com.zcs.sdk.SdkResult;
import com.zcs.sdk.emv.EmvApp;
import com.zcs.sdk.emv.EmvCapk;
import com.zcs.sdk.emv.EmvHandler;
import com.zcs.sdk.emv.EmvTermParam;
import com.zcs.sdk.pin.pinpad.PinPadManager;
import com.zcs.sdk.print.PrnStrFormat;
import com.zcs.sdk.util.StringUtils;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CountDownLatch;

/** SmartpospluginPlugin */
public class SmartpospluginPlugin implements ActivityAware,FlutterPlugin,MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private static MethodChannel channel;
  private Activity activity;
  private String response="-1";
  private Context mContext;
 // Context context;
  private  static CountDownLatch mLatch;
  private  static Sys sys = DriverManager.getInstance().getBaseSysDevice();
  private  static EmvImple emvp;
  private static CardReaderManager mCardReadManager = DriverManager.getInstance().getCardReadManager();
  private  static ICCard iccCard = mCardReadManager.getICCard();
  private static MagCard mMAGCard=mCardReadManager.getMAGCard();
  private static RfCard mRFCard=mCardReadManager.getRFCard();
  private static PinPadManager  mPinPadManager = DriverManager.getInstance().getPadManager();
//  private Printer mPrinter=DriverManager.getInstance().getPrinter();

  Handler mainHandler = new Handler(Looper.getMainLooper());
   public  void sendMessageToFultter(String method,String message){
       // 通知Flutter层代码
       mLatch=new CountDownLatch(1);
       Log.d("Debug","sendMessageToFultter="+method);
       mainHandler.post(new Runnable() {
           @Override
           public void run() {
               if(channel==null){
                   Log.d("Debug","channel is null");
                   return;
               }
                 channel.invokeMethod(method, message);
             //  sendMessageToFlutter(message);
           }
           });

       try {
           mLatch.await();
       } catch (InterruptedException e) {
           e.printStackTrace();
       }
   }


    // 发送消息给Flutter
    private void sendMessageToFlutter(String message) {
        channel.invokeMethod("receiveMessage", message);
    }


    public CardSlotNoEnum intToEnum(int value) {
        for (CardSlotNoEnum e : CardSlotNoEnum.values()) {
            if (e.getType() == value) {
                return e;
            }
        }
        throw new IllegalArgumentException("Invalid value: " + value);
    }


  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "smartposplugin");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

      ResponseData responseData = new ResponseData();


      if(call.method.equals("messageCall")){

          String resp= call.arguments();
         // Log.d("Debug","alex message="+resp);


          if(resp.startsWith("onlineProc:")) {

              String[] parts = resp.substring(11).split(";");

              parts[0]=parts[0]+'\0';

              byte[] authRespCode=parts[0].getBytes();

              byte[] issuerResp=StringUtils.convertHexToBytes(parts[1]);

             int issuerRespLen=issuerResp.length;

              int iSendRet = emvp.separateOnlineResp(authRespCode, issuerResp, issuerRespLen);


              emvp.setReturnCode(iSendRet);

              Log.d("Debug", "separateOnlineResp iSendRet=" + iSendRet);

          }
          else if(resp.startsWith("onSelApp:")) {


              int pos= resp.indexOf(':');
              String respcode=resp.substring(pos+1, resp.length());
              int recode=Integer.parseInt(respcode);
              emvp.setReturnCode(recode);


          } else if(resp.startsWith("onCertVerify:")) {

              int pos= resp.indexOf(':');
              String respcode=resp.substring(pos+1, resp.length());
              int recode=Integer.parseInt(respcode);
              emvp.setReturnCode(recode);


          }else if(resp.startsWith("onConfirmCardNo:")) {


              int pos= resp.indexOf(':');
              String respcode=resp.substring(pos+1, resp.length());
              int recode=Integer.parseInt(respcode);
              emvp.setReturnCode(recode);

          }

          mLatch.countDown();
          return;
      }


      if(call.method.equals("onlinePinPad")){

          new Thread(new Runnable() {
              @Override
              public void run() {

                  String pan=call.argument("pan");

                  Log.d("Debug",pan);
                  int status= EmvImple.getInstance().callOnlinePinPad(activity.getApplicationContext(),pan);
                  responseData.setResult(status);

               //   Log.d("Debug",EmvImple.getInstance().getPinBlock());
                  responseData.setResponse(EmvImple.getInstance().getPinBlock());
                  response= responseData.getResponseStr();
                  result.success(response);
              }
          }).start();
      }
      else if(call.method.equals("emvTrans")){


          if(emvp==null){

              responseData.setResponse("emvInit has not call");
              responseData.setResult(-255);
              response= responseData.getResponseStr();
              result.success(response);
              return;

          }

          int cardType = call.argument("cardType");


          new Thread(new Runnable() {
              @Override
              public void run() {

                  int status1= emvp.emv(cardType);

                  responseData.setEmvResult(emvp.getEmvTransResult());
                  responseData.setResult(status1);
                  responseData.setResponse(emvp.getEmvData());
                  response= responseData.getResponseStr();


                 // response=String.valueOf(status1);
                //  response+=",EmvResult:"+emvp.getEmvTransResult();
               //   Log.d("Debug","response:"+response);
                  result.success(response);

              }
          }).start();
      }else{

          String response=  methodHandler(call);
          result.success(response);
      }


      //result.notImplemented();

  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }

  @Override
  public void onAttachedToActivity(@NonNull ActivityPluginBinding binding) {
    activity=binding.getActivity();


  }

  @Override
  public void onDetachedFromActivityForConfigChanges() {
    this.onDetachedFromActivity();;
  }

  @Override
  public void onReattachedToActivityForConfigChanges(@NonNull ActivityPluginBinding binding) {
    this.onAttachedToActivity(binding);
  }

  @Override
  public void onDetachedFromActivity() {
    activity=null;
  }


  private String methodHandler(MethodCall call){



      ResponseData responseData = new ResponseData();
      String response="";
      int status=-1;
       if(call.method.equals("sysInit")){

            status =sys.sdkInit();
           responseData.setResult(status);
            response= responseData.getResponseStr();
           return response;
       }
      if(call.method.equals("getPid")){

           String[] pid = new String[1];
           status =sys.getPid(pid);
          responseData.setResult(status);

          if(status== SdkResult.SDK_OK){
              responseData.setResponse(pid[0]);
          }

          response= responseData.getResponseStr();
          return response;
      }
      if(call.method.equals("getFirmwareVer")){

          final String[] fVerion = new String[1];
           status =sys.getFirmwareVer(fVerion);
           responseData.setResult(status);
            if(status== SdkResult.SDK_OK){

                responseData.setResponse(fVerion[0]);
            }
             response= responseData.getResponseStr();
            return response;
      }

      if(call.method.equals("addCapk")){

          if(emvp==null){

              responseData.setResult(-255);

              responseData.setResponse("emvInit has not call");

              response= responseData.getResponseStr();
              return response;

          }

          String resp="";
          resp= call.argument("capk");

      //    Log.d("Debug","resp="+resp);
          String[] parts = resp.split(";");
          EmvCapk capk = new EmvCapk();

          capk.setKeyID((byte) Integer.parseInt(parts[0]));
          capk.setRID(parts[1]);
          capk.setCapkIndicator((byte) Integer.parseInt(parts[2]));
          capk.setHashIndicator((byte) Integer.parseInt(parts[3]));
          capk.setModul(parts[4]);
          capk.setExponent(parts[5]);
          capk.setCheckSum(parts[6]);
          capk.setExpDate(parts[7]);
          status=emvp.addCapk(capk);
         // response =String.valueOf(status);
          responseData.setResult(status);
          response= responseData.getResponseStr();
          return response;
      }
      if(call.method.equals("addApp")){

          if(emvp==null){

             // response="-255,+emvInit has not call";
              responseData.setResponse("emvInit has not call");
              responseData.setResult(-255);
              response= responseData.getResponseStr();
              return response;

          }

          String resp="";
          resp= call.argument("aid");

       //  Log.d("Debug","resp="+resp);
          String[] parts = resp.split(";");
          EmvApp app = new EmvApp();

          app.setAid(parts[0]);
          app.setSelFlag((byte) Integer.parseInt(parts[1]));
          app.setTargetPer((byte) Integer.parseInt(parts[2]));
          app.setMaxTargetPer((byte) Integer.parseInt(parts[3]));
          app.setFloorLimit(Integer.parseInt(parts[4]));
          app.setOnLinePINFlag((byte)Integer.parseInt(parts[5]));
          app.setThreshold(Integer.parseInt(parts[6]));
          app.setTacDefault(parts[7]);
          app.setTacDenial(parts[8]);
          app.setTacOnline(parts[9]);
          app.setdDOL(parts[10]);
          app.settDOL(parts[11]);

          app.setVersion(parts[12]);
          app.setClTransLimit(parts[13]);
          app.setClOfflineLimit(parts[14]);
          app.setClCVMLimit(parts[15]);
          app.setEcTTLVal(parts[16]);
          app.setAcquierId(parts[17]);
          app.setMerchCateCode(parts[18]);
          app.setMerchId(parts[19]);
          app.setMerName(parts[20]);
          app.setTermId(parts[21]);
          app.setTransCurrCode(parts[22]);
          app.setTransCurrExp((byte)Integer.parseInt(parts[23]));
          app.setTransRefCode(parts[24]);
          app.setTransCurrExp((byte)Integer.parseInt(parts[25]));
          app.setTerRisk(parts[26]);
          app.setUdol(parts[27]);
          app.setMagStripeInd((byte)Integer.parseInt(parts[28]));

          app.setMagStripeVer(parts[29]);
          app.setTermCapNoCVMReq(parts[30]);
          app.setTermCapCVMReq(parts[31]);
          app.setPayPassAddTermCapa(parts[32]);
          app.setPayPassTermType((byte)Integer.parseInt(parts[33]));
          status= emvp.addApp(app);
        //  response =String.valueOf(status);

          responseData.setResult(status);
          response= responseData.getResponseStr();

          return response;
      }

      if(call.method.equals("delAllCapk")){

          if(emvp==null){

              responseData.setResponse("emvInit has not call");
              responseData.setResult(-255);
              response= responseData.getResponseStr();

              return response;

          }
          emvp.delAllCapk();
          status=0;
          responseData.setResult(status);
          response= responseData.getResponseStr();

          return response;
      }
      if(call.method.equals("delAllAid")){

          if(emvp==null){
              responseData.setResponse("emvInit has not call");
              responseData.setResult(-255);
              response= responseData.getResponseStr();
              return response;

          }
         emvp.delAllApp();
          status=0;
          responseData.setResult(status);
          response= responseData.getResponseStr();
          return response;
      }
      if(call.method.equals("emvInit")){


          emvp =EmvImple.getInstance();

          status=emvp.EmvInit(activity.getApplicationContext());

        //  response =String.valueOf(status);
          responseData.setResult(status);
          response= responseData.getResponseStr();

          return response;
      }
      if(call.method.equals("getEmvData")){

          if(emvp==null){

             // response="-255,+emvInit has not call";
              responseData.setResponse("emvInit has not call");
              responseData.setResult(-255);
              response= responseData.getResponseStr();
              return response;

          }
          status=0;
          responseData.setResult(status);
          responseData.setResponse(emvp.getEmvData());
          response= responseData.getResponseStr();

          return response;
      }

      if(call.method.equals("emvTransParamSet")){

          if(emvp==null){

            //  response="-255,+emvInit has not call";
              responseData.setResponse("emvInit has not call");
              responseData.setResult(-255);
              response= responseData.getResponseStr();
              return response;

          }

          String resp="";
          resp= call.argument("data");

       //   Log.d("Debug","resp="+resp);
          String[] parts = resp.split(";");


          emvp.emvTransParam.setTerminalSupportIndicator((byte)Integer.parseInt(parts[0]));
          emvp.emvTransParam.setIsForceOnline((byte)Integer.parseInt(parts[1]));
          emvp.emvTransParam.setReaderTTQ(parts[2]);
          emvp.emvTransParam.setTransNo(parts[3]);
          emvp.emvTransParam.setTransDate(parts[4]);
          emvp.emvTransParam.setTransTime(parts[5]);
          emvp.emvTransParam.setAmountAuth(parts[6]);
          emvp.emvTransParam.setAmountOther(parts[7]);
          emvp.emvTransParam.setTransType((byte)Integer.parseInt(parts[8]));
         // response="0";
          responseData.setResult(0);
          response= responseData.getResponseStr();
          return response;
      }

      if(call.method.equals("emvTermParamSet")){

          String resp="";
          resp= call.argument("data");

          String[] parts = resp.split(";");
          EmvTermParam.ifd=parts[0];
          EmvTermParam.terminalCountry=parts[1];
          EmvTermParam.termType=(byte)Integer.parseInt(parts[2]);
          EmvTermParam.termCapa=parts[3];
          EmvTermParam.addTermCapa=parts[4];
          EmvTermParam.merchantNameLocation=parts[5];
          EmvTermParam.merchantCode=parts[6];
          EmvTermParam.merchantID=parts[7];
          EmvTermParam.acquirerID=parts[8];
          EmvTermParam.termID=parts[9];
          EmvTermParam.tranRefCurrExp=(byte)Integer.parseInt(parts[10]);

          Log.d("Debug","ret="+ EmvTermParam.tranRefCurrExp);
          EmvTermParam.tranRefCurr=parts[11];
          EmvTermParam.tranCurrExp=(byte)Integer.parseInt(parts[12]);
          EmvTermParam.tranCurrCode=parts[13];
          EmvTermParam.termFLmtFlg=(byte)Integer.parseInt(parts[14]);
          EmvTermParam.rfTxnLmtFlg=(byte)Integer.parseInt(parts[15]);
          EmvTermParam.rfFLmtFlg=(byte)Integer.parseInt(parts[16]);
          EmvTermParam.rfCVMLmtFlg=(byte)Integer.parseInt(parts[17]);
          EmvTermParam.rfStatusCheckFlg=(byte)Integer.parseInt(parts[18]);
          EmvTermParam.rfZeroAmtNoAllowed=(byte)Integer.parseInt(parts[19]);
          responseData.setResult(0);
          response= responseData.getResponseStr();
          return response;
      }

      if(call.method.equals("separateOnlineResp")){

          String  resp= call.argument("data");
        //  byte[] authRespCode = new byte[3];
         // byte[] issuerResp = new byte[512];
          //int[] issuerRespLen = new int[1];

          String[] parts = resp.split(";");


          byte[] authRespCode = parts[0].getBytes();
          byte[] issuerResp=parts[1].getBytes();

          int issuerRespLen=issuerResp.length;

          Log.d("Debug","alex issuerRespLen="+issuerRespLen);

          int iSendRet = emvp.separateOnlineResp(authRespCode, issuerResp, issuerRespLen);
          Log.d("Debug","alex iSendRet="+iSendRet);
        //  response =String.valueOf(iSendRet);

          responseData.setResult(iSendRet);
          response= responseData.getResponseStr();

          return response;


      }


      if(call.method.equals("sdkIccReset")){

            int slot=0;
            slot= call.argument("ucSlotNo");

          CardSlotNoEnum slotEnum = intToEnum(slot);
          status=iccCard.icCardReset(slotEnum);
          responseData.setResult(status);
          response= responseData.getResponseStr();

            return response;
      }
      if(call.method.equals("sdkIccExchangeAPDU")){

          int slot = call.argument("ucSlotNo");

       //   Log.d("Debug","slot="+slot);

          byte[] sendbytes = call.argument("data");
          byte[] mReceivedData = new byte[300];
          int[] mReceivedDataLength = new int[1];
          CardSlotNoEnum slotEnum = intToEnum(slot);
          status = iccCard.icExchangeAPDU(slotEnum, sendbytes, mReceivedData, mReceivedDataLength);

          responseData.setResult(status);
          if(status==0) {
              byte [] resp=new byte[mReceivedDataLength[0]];
              System.arraycopy(mReceivedData, 0, resp, 0, mReceivedDataLength[0]);

              responseData.setResponse(StringUtils.convertBytesToHex(resp));
          }
          response= responseData.getResponseStr();

          return response;
      }
      if(call.method.equals("sdkIccGetStatus")){


          int slot = call.argument("ucSlotNo");

          CardSlotNoEnum slotEnum = intToEnum(slot);
          status = iccCard.getIcCardStatus(slotEnum);

          responseData.setResult(status);
          response= responseData.getResponseStr();

             return response;
      }
      if(call.method.equals("sdkIccPowerDown")){

          int slot = call.argument("ucSlotNo");

          CardSlotNoEnum slotEnum = intToEnum(slot);
          status = iccCard.icCardPowerDown(slotEnum);
          responseData.setResult(status);
          response= responseData.getResponseStr();

         // response =String.valueOf(status);
          return response;
      }
      if(call.method.equals("sdkRfCpuReset")){

          byte[] resetData=new byte[64];
          int[] dataLength=new int[1];

          status=mRFCard.rfReset(resetData, dataLength);
          responseData.setResult(status);
          if(status==0){

              byte[] resp=new byte[dataLength[0]];

              responseData.setResponse(StringUtils.convertBytesToHex(resp));
          }

          response= responseData.getResponseStr();

          return response;
      }
      if(call.method.equals("sdkRfSearchCard")){

          byte[] outCardType=new byte[1];
          byte[] uid = new byte[16];
          byte[] uidLength = new byte[1];
          byte[] atrLength = new byte[1];
          byte[] atr = new byte[300];

          int cardType = call.argument("cardType");
          status=mRFCard.rfSearchCard((byte) cardType,outCardType,uidLength,uid,atrLength,atr);

          responseData.setResult(status);

          if(status==0){

              byte[] relUid=new byte[uidLength[0]];
              System.arraycopy(uid, 0, relUid, 0, uidLength[0]);
              response="outCardType:"+outCardType[0]+","+"uid:"+StringUtils.convertBytesToHex(relUid);
              responseData.setResponse(response);
          }

          response= responseData.getResponseStr();
          return response;
      }

      if(call.method.equals("sdkRfExchangeAPDU")){


          Log.d("Debug","sdkRfExchangeAPDU");

          byte[] sendbytes = call.argument("data");
          byte[] mReceivedData = new byte[300];
          int[] mReceivedDataLength = new int[1];
          status=mRFCard.rfExchangeAPDU(sendbytes, mReceivedData, mReceivedDataLength);
          responseData.setResult(status);

          if(status==0){

              byte [] resp=new byte[mReceivedDataLength[0]];
              System.arraycopy(mReceivedData, 0, resp, 0, mReceivedDataLength[0]);

              response= StringUtils.convertBytesToHex(resp);
              responseData.setResponse(response);
          }
          response= responseData.getResponseStr();
          return response;
      }

      if(call.method.equals("sdkRfPowerOn")){

          status=mRFCard.rfCardPowerOn();
         // response =String.valueOf(status);
          responseData.setResult(status);
          response= responseData.getResponseStr();
          return response;
      }
      if(call.method.equals("sdkRfPowerDown")){


          status=mRFCard.rfCardPowerDown();
         // response =String.valueOf(status);
          responseData.setResult(status);
          response= responseData.getResponseStr();
          return response;
      }

      if(call.method.equals("sdkMagOpen")){


          status=mMAGCard.magCardOpen();
          //response =String.valueOf(status);
          responseData.setResult(status);
          response= responseData.getResponseStr();
          return response;
      }

      if(call.method.equals("sdkMagClose")){


          mMAGCard.magCardClose();
          responseData.setResult(0);
          response= responseData.getResponseStr();
          return response;
      }
      if(call.method.equals("sdkMagIfBrush")){


          status=mMAGCard.isMagBrush();
          //response =String.valueOf(status);
          responseData.setResult(status);
          response= responseData.getResponseStr();
          return response;
      }
      if(call.method.equals("sdkMagClearData")){


          status=mMAGCard.magClearData();
         // response =String.valueOf(status);
          responseData.setResult(status);
          response= responseData.getResponseStr();
          return response;
      }
      if(call.method.equals("sdkMagReadData")){
          CardInfoEntity magReadData = mCardReadManager.getMAGCard().getMagReadData();

          responseData.setResult(magReadData.getResultcode());

          if (magReadData.getResultcode() == SdkResult.SDK_OK) {
              String tk1 = magReadData.getTk1();
              String tk2 = magReadData.getTk2();
              String tk3 = magReadData.getTk3();
              String expiredDate = magReadData.getExpiredDate();
              String cardNo = magReadData.getCardNo();

              response=tk1+";"+tk2+";"+tk3+";"+expiredDate+";"+cardNo+";";

              responseData.setResponse(response);
              responseData.setTrack1(tk1);
              responseData.setTrack2(tk2);
              responseData.setTrack3(tk3);
              responseData.setTrack3(expiredDate);
              responseData.setTrack3(cardNo);
          }
          response= responseData.getResponseStr();

          return response;
      }


      if(call.method.equals("sdkPrnBitmap")){

          byte[] sendbytes = call.argument("data");
          Printer mPrinter=DriverManager.getInstance().getPrinter();

          int printStatus = mPrinter.getPrinterStatus();
          responseData.setResult(printStatus);

          if(printStatus!=0){

              response= responseData.getResponseStr();
              return response;

          }



              Bitmap mBitmapDef = BitmapFactory.decodeByteArray(sendbytes, 0, sendbytes.length);
              PrnStrFormat format = new PrnStrFormat();
              mPrinter.setPrintAppendBitmap(mBitmapDef, Layout.Alignment.ALIGN_CENTER);
              mPrinter.setPrintAppendString(" ", format);
              mPrinter.setPrintAppendString(" ", format);
              mPrinter.setPrintAppendString(" ", format);
              printStatus=  mPrinter.setPrintStart();

              responseData.setResult(printStatus);
              response= responseData.getResponseStr();
          return response;
      }

      if(call.method.equals("sdkPrnStr")){

          Printer mPrinter=DriverManager.getInstance().getPrinter();
          byte[] sendbytes = call.argument("data");
          int printStatus =mPrinter.setPrintString(sendbytes);
          responseData.setResult(printStatus);
          response= responseData.getResponseStr();

        //  response =String.valueOf(printStatus);
          return response;

      }

      if(call.method.equals("getPrinterStatus")){

          Printer mPrinter=DriverManager.getInstance().getPrinter();
          int printStatus = mPrinter.getPrinterStatus();

          responseData.setResult(printStatus);
          response= responseData.getResponseStr();

          //response =String.valueOf(printStatus);
          return response;

      }


      if(call.method.equals("printEpson")){

          Printer mPrinter=DriverManager.getInstance().getPrinter();
          byte[] sendbytes = call.argument("data");
          int printStatus =mPrinter.printEpson(sendbytes);

        //  response =String.valueOf(printStatus);

          responseData.setResult(printStatus);
          response= responseData.getResponseStr();


          return response;

      }


      if(call.method.equals("pinPadUpMastKey")){


          int keyindex = call.argument("keynum");
          String keystr=call.argument("data");

          byte[] key_byte = StringUtils.convertHexToBytes(keystr);

           status = mPinPadManager.pinPadUpMastKey(keyindex, key_byte, (byte) key_byte.length);

         // response =String.valueOf(status);

          responseData.setResult(status);
          response= responseData.getResponseStr();

          return response;
      }

      if(call.method.equals("pinPadUpWorkKey")){


          int keyindex = call.argument("keynum");

        //  call.argument("data");

          String pinkeystr  = call.argument("pinkey");
          String mackeystr = call.argument("mackey");
          String tdkeystr =call.argument("tdkey");

          byte[] pin_key_byte= StringUtils.convertHexToBytes(pinkeystr);
          byte[] mac_key_byte= StringUtils.convertHexToBytes(mackeystr);
          byte[] tdk_key_byte= StringUtils.convertHexToBytes(tdkeystr);


          status = mPinPadManager.pinPadUpWorkKey(keyindex, pin_key_byte, (byte) pin_key_byte.length,
                mac_key_byte, (byte) mac_key_byte.length, tdk_key_byte, (byte) tdk_key_byte.length);

         // response =String.valueOf(status);

          responseData.setResult(status);
          response= responseData.getResponseStr();

          return response;
      }

      if(call.method.equals("charEncode"))
      {

          String datastr  = call.argument("data");
          String formatystr = call.argument("format");

                try {
                    byte[] bytes=datastr.getBytes(formatystr);

                    status=-1;
                    if(bytes!=null){

                        status=0;

                    }
                    responseData.setReponsebytes(bytes);
                    responseData.setResult(status);
                    response= responseData.getResponseStr();
                }catch (Exception e){

                    e.printStackTrace();
                    status=-3;
                    responseData.setResult(status);
                    response= responseData.getResponseStr();
                }

          return response;
      }

      if(call.method.equals("setFontLib")){

          int codepage  = call.argument("codePage");

          Printer mPrinter=DriverManager.getInstance().getPrinter();
          status = mPrinter.setPrintFontLib((byte)codepage);
          responseData.setResult(status);

          response= responseData.getResponseStr();

          return response;

      }




      return null;

  }


}
