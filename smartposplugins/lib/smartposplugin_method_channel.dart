
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';


import 'emvApp.dart';
import 'emvCapk.dart';
import 'emvTermParam.dart';
import 'emvTransParam.dart';
import 'smartposplugin_platform_interface.dart';


/**
* 文件名：[smartposplugin_method_channel]
* 作者：[alex]
* 创建时间：[20230707]
* 文件描述：[]
*/




/// An implementation of [SmartpospluginPlatform] that uses method channels.
class MethodChannelSmartposplugin extends SmartpospluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('smartposplugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String>  sysInit()  async {

    final status =  await methodChannel.invokeMethod('sysInit');
    return status;
  }

  @override
  Future<String>  getPid()  async {

    final status =  await methodChannel.invokeMethod('getPid');

    return status;
  }

  @override
  Future<String>  getFirmwareVer()  async {

    final status =  await methodChannel.invokeMethod('getFirmwareVer');

    return status;
  }


  @override
  void showLog(int level) {

      methodChannel.invokeMethod('showLog',{'level':level});
  }

  @override
  Future<String> emvInit() async{

    final status =  await methodChannel.invokeMethod('emvInit');

    return status;
  }
  @override
  Future<String>  emvTrans(int cardType)  async {

    final status =  await methodChannel.invokeMethod('emvTrans',{'cardType': cardType});

    return status;
  }


  @override
  Future<String> emvTransParamSet(EmvTransParam emvparm) async{


    String par="${emvparm.getTerminalSupportIndicator()};${emvparm.getIsForceOnline()};${emvparm.getReaderTTQ()};${emvparm.getTransNo()};${emvparm.getTransDate()};${emvparm.getTransTime()};${emvparm.getAmountAuth()};${emvparm.getAmountOther()};${emvparm.getTransType()};";

    final status =  await methodChannel.invokeMethod('emvTransParamSet',{'data': par});

    return status;
  }

  @override
  Future<String> emvTermParamSet(EmvTermParam emvparm) async{


    String par="${emvparm.getIfd()};${emvparm.getTerminalCountry()};${emvparm.getTermType()};${emvparm.getTermCapa()};${emvparm.getAddTermCapa()};${emvparm.getMerchantNameLocation()};${emvparm.getMerchantCode()};${emvparm.getMerchantID()};${emvparm.getAcquirerID()};${emvparm.getTermID()};${emvparm.getTranRefCurrExp()};${emvparm.getTranRefCurr()};${emvparm.getTranCurrExp()};${emvparm.getTranCurrCode()};${emvparm.getTermFLmtFlg()};${emvparm.getRfTxnLmtFlg()};${emvparm.getRfFLmtFlg()};${emvparm.getRfCVMLmtFlg()};${emvparm.getRfStatusCheckFlg()};${emvparm.getRfZeroAmtNoAllowed()};";


    final status =  await methodChannel.invokeMethod('emvTermParamSet',{'data': par});

    return status;
  }



  @override
  Future<String> getEmvData() async {

    final status =  await methodChannel.invokeMethod('getEmvData');

    return status;
  }

  @override
  Future<String> addCapk(EmvCapk capk) async{


    String capkPar="${capk.getKeyID()};${capk.getRID()};${capk.getCapkIndicator()};${capk.getHashIndicator()};${capk.getModul()};${capk.getExponent()};${capk.getCheckSum()};${capk.getExpDate()};";

    final status =  await methodChannel.invokeMethod('addCapk',{'capk': capkPar});

    return status;
  }
  @override
  Future<String> addApp(EmvApp aid) async{



    String aidParm="${aid.getAid()};${aid.getSelFlag()};${aid.getTargetPer()};${aid.getMaxTargetPer()};${aid.getFloorLimit()};${aid.getOnLinePINFlag()};${aid.getThreshold()};${aid.getTacDefault()};${aid.getTacDenial()};${aid.getTacOnline()};${aid.getDDOL()};${aid.getTDOL()};${aid.getVersion()};${aid.getClTransLimit()};${aid.getClOfflineLimit()};${aid.getClCVMLimit()};${aid.getEcTTLVal()};${aid.getAcquierId()};${aid.getMerchCateCode()};${aid.getMerchId()};${aid.getMerName()};${aid.getTermId()};${aid.getTransCurrCode()};${aid.getTransCurrExp()};${aid.getTransRefCode()};${aid.getTransRefExp()};${aid.getTerRisk()};${aid.getUdol()};${aid.getMagStripeInd()};${aid.getMagStripeVer()};${aid.getTermCapNoCVMReq()};${aid.getTermCapCVMReq()};${aid.getPayPassAddTermCapa()};${aid.getPayPassTermType()};";


    final status =  await methodChannel.invokeMethod('addApp',{'aid': aidParm});

    return status;
  }

  @override
  Future<String> delAllCapk() async{

    final status =  await methodChannel.invokeMethod('delAllCapk');

    return status;
  }
  @override
  Future<String> delAllAid() async{

    final status =  await methodChannel.invokeMethod('delAllAid');

    return status;
  }


  @override
  Future<String> sdkIccReset(int ucSlotNo) async{

    final status =  await methodChannel.invokeMethod('sdkIccReset',{'ucSlotNo': ucSlotNo});

    return status;

  }

  @override
  Future<String> sdkIccGetStatus(int ucSlotNo) async {

    final status =  await methodChannel.invokeMethod('sdkIccGetStatus',{'ucSlotNo': ucSlotNo});

    return status;
  }


  @override
  Future<String> sdkIccExchangeAPDU(int ucSlotNo, Uint8List sendApdu) async {

    final status =  await methodChannel.invokeMethod('sdkIccExchangeAPDU', {'ucSlotNo': ucSlotNo,'data': sendApdu});

    return status;
  }

  @override
  Future<String> sdkIccPowerDown(int ucSlotNo) async {
    final status =  await methodChannel.invokeMethod('sdkIccPowerDown',{'ucSlotNo': ucSlotNo});

    return status;
  }



  @override
  Future<String> sdkRfCpuReset() async {


    final status =  await methodChannel.invokeMethod('sdkRfCpuReset');

    return status;

  }

  @override
  Future<String> sdkMifReadValue(int ucBlock) async {

    final status =  await methodChannel.invokeMethod('sdkMifReadValue',{'ucBlock':ucBlock});

    return status;

  }

  @override
  Future<String> sdkMifValueOperate(int ucBlock, int type, int value) async {

    final status =  await methodChannel.invokeMethod('sdkMifValueOperate',{'ucBlock':ucBlock,'type':Type,'value':value});

    return status;
  }

  @override
  Future<String> sdkMifchangeKey(int ucBlock, int ucKeyType, Uint8List pucKey) async {

    final status =  await methodChannel.invokeMethod('sdkMifchangeKey',{'ucBlock':ucBlock,'ucKeyType':ucKeyType,'Key':pucKey});

    return status;
  }

  @override
  Future<String> sdkMifWriteBlock(int ucBlock, Uint8List pucDataIn) async {

    final status =  await methodChannel.invokeMethod('sdkMifWriteBlock',{'ucBlock':ucBlock,'data':pucDataIn});

    return status;
  }

  @override
  Future<String> sdkMifReadBlock(int ucBlock) async {

    final status =  await methodChannel.invokeMethod('sdkMifReadBlock',{'ucBlock':ucBlock});

    return status;
  }

  @override
  Future<String> sdkMifVerifyKey(int ucBlock, int ucKeyType, Uint8List pucKey) async {

    final status =  await methodChannel.invokeMethod('sdkMifVerifyKey',{'ucBlock':ucBlock,'KeyType':ucKeyType,'Key':pucKey});

    return status;
  }

  @override
  Future<String> sdkRfExchangeAPDU(Uint8List sendApdu) async {

    final status =  await methodChannel.invokeMethod('sdkRfExchangeAPDU',{'data':sendApdu});

    return status;
  }

  @override
  Future<String> sdkRfSearchCard(int ucInCardType) async {

    final status =  await methodChannel.invokeMethod('sdkRfSearchCard',{'cardType':ucInCardType});

    return status;
  }

  @override
  Future<String> sdkRfPowerDown() async {

    final status =  await methodChannel.invokeMethod('sdkRfPowerDown');

    return status;
  }

  @override
  Future<String> sdkRfPowerOn() async {

    final status =  await methodChannel.invokeMethod('sdkRfPowerOn');

    return status;
  }

  @override
  Future<String> sdkMagReadData() async {

    final status =  await methodChannel.invokeMethod('sdkMagReadData');

    return status;
  }

  @override
  Future<String> sdkMagClearData() async {

    final status =  await methodChannel.invokeMethod('sdkMagClearData');

    return status;
  }

  @override
  Future<String> sdkMagIfBrush() async {

    final status =  await methodChannel.invokeMethod('sdkMagIfBrush');

    return status;
  }

  @override
  Future<String> sdkMagClose() async {

    final status =  await methodChannel.invokeMethod('sdkMagClose');

    return status;
  }

  @override
  Future<String> sdkMagOpen() async {

    final status =  await methodChannel.invokeMethod('sdkMagOpen');

    return status;
  }


  @override
  Future<String> sdkPrnBitmap(Uint8List pucBitmap) async {

    final status =  await methodChannel.invokeMethod('sdkPrnBitmap',{'data':pucBitmap});

    return status;
  }


  @override
  Future<String> sdkPrnStr(Uint8List pucStr) async {

    final status =  await methodChannel.invokeMethod('sdkPrnStr',{'data':pucStr});

    return status;
  }


  @override
  Future<String> getPrinterStatus() async{

    final status =  await methodChannel.invokeMethod('getPrinterStatus');

    return status;
  }



  @override
  Future<String> printEpson(Uint8List pucStr) async {

    final status =  await methodChannel.invokeMethod('printEpson',{'data':pucStr});
    return status;

  }


  @override
  Future<String> separateOnlineResp(String pucStr) async{

    final status =  await methodChannel.invokeMethod('separateOnlineResp',{'data':pucStr});

    return status;
  }


  Future<String> pinPadUpMastKey(int keynum,String ckeyStr) async {

    final status =  await methodChannel.invokeMethod('pinPadUpMastKey',{'keynum':keynum,'data':ckeyStr});

    return status;
  }

  Future<String> pinPadUpWorkKey(int keynum,String pin_keystr, String mac_keystr,String tdk_keystr) async{

    final status =  await methodChannel.invokeMethod('pinPadUpWorkKey',{'keynum':keynum,'pinkey':pin_keystr,'mackey':mac_keystr,'tdkey':tdk_keystr});

    return status;
  }



  Future<String> charEncode(String ckeyStr,String format) async {

    final status =  await methodChannel.invokeMethod('charEncode',{'data':ckeyStr,'format':format});

    return status;
  }


  Future<String> setFontLib(int codePage) async {

    final status =  await methodChannel.invokeMethod('setFontLib',{'codePage':codePage});

    return status;
  }


  Future<String> onlinePinPad(String pan) async {

    final status =  await methodChannel.invokeMethod('onlinePinPad',{'pan':pan});

    return status;
  }

}
