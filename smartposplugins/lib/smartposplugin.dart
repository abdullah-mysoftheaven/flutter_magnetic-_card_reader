
import 'package:flutter/services.dart';

import 'emvApp.dart';
import 'emvCapk.dart';
import 'emvTermParam.dart';
import 'emvTransParam.dart';
import 'smartposplugin_platform_interface.dart';


///**
/// * 文件名：[smartposplugin]
/// * 作者：[alex]
/// * 创建时间：[20230707]
/// * 文件描述：[]
/// */


class Smartposplugin {



  static Smartposplugin _instance= Smartposplugin._();

  Smartposplugin._(); // 私有构造函数

  static Smartposplugin getInstance() {
    _instance ??= Smartposplugin._();
    return _instance;
  }


  Future<String?> getPlatformVersion() {

    return SmartpospluginPlatform.instance.getPlatformVersion();
  }

  Future<String> sysInit()  {

    return SmartpospluginPlatform.instance.sysInit();
  }

  Future<String> getPid(){


    return SmartpospluginPlatform.instance.getPid();

  }

  Future<String> getFirmwareVer(){

     return SmartpospluginPlatform.instance.getFirmwareVer();
  }

  void showLog(int level){

    return SmartpospluginPlatform.instance.showLog(level);
  }

  Future<String> emvInit(){

    return SmartpospluginPlatform.instance.emvInit();
  }

  Future<String> emvTermParamSet(EmvTermParam emvparm){

    return SmartpospluginPlatform.instance.emvTermParamSet(emvparm);
  }

  Future<String> emvTransParamSet(EmvTransParam emvparm){

    return SmartpospluginPlatform.instance.emvTransParamSet(emvparm);
  }

  Future<String> emvTrans(int cardType){

    return SmartpospluginPlatform.instance.emvTrans(cardType);
  }

  Future<String> addCapk(EmvCapk capk){

    return SmartpospluginPlatform.instance.addCapk(capk);
  }
  Future<String> addApp(EmvApp aid){

    return SmartpospluginPlatform.instance.addApp(aid);
  }
  Future<String> delAllCapk(){

    return SmartpospluginPlatform.instance.delAllCapk();
  }
  Future<String> delAllAid(){

    return SmartpospluginPlatform.instance.delAllAid();
  }


  Future<String> iccRest(int slot){

    return SmartpospluginPlatform.instance.sdkIccReset(slot);
  }

  Future<String> iccExchangeAPDU(int slot,Uint8List bytes){

    return SmartpospluginPlatform.instance.sdkIccExchangeAPDU(slot,bytes);
  }

  Future<String> iccPowerDown(int slot){

    return SmartpospluginPlatform.instance.sdkIccPowerDown(slot);
  }

  Future<String> iccGetStatus(int slot){

    return SmartpospluginPlatform.instance.sdkIccGetStatus(slot);
  }


  Future<String> rfRest(){

    return SmartpospluginPlatform.instance.sdkRfCpuReset();
  }

  Future<String> rfSearchCard(int cardType){

    return SmartpospluginPlatform.instance.sdkRfSearchCard(cardType);
  }


  Future<String> rfExchangeAPDU(Uint8List sendApdu){

    return SmartpospluginPlatform.instance.sdkRfExchangeAPDU(sendApdu);
  }

  Future<String> rfPowerDown(){

    return SmartpospluginPlatform.instance.sdkRfPowerDown();
  }


  Future<String> getEmvData(){

    return SmartpospluginPlatform.instance.getEmvData();
  }


  Future<String> magOpen(){

    return SmartpospluginPlatform.instance.sdkMagOpen();
  }

  Future<String> magClose(){
    return SmartpospluginPlatform.instance.sdkMagClose();
  }

  Future<String> magIfBrush(){

    return SmartpospluginPlatform.instance.sdkMagIfBrush();
  }

  Future<String> magClearData(){
    return SmartpospluginPlatform.instance.sdkMagClearData();
  }

  Future<String> magReadData(){
    return SmartpospluginPlatform.instance.sdkMagReadData();
  }


  Future<String> prnBitmap(Uint8List pucBitmap){
    return SmartpospluginPlatform.instance.sdkPrnBitmap(pucBitmap);
  }

  Future<String> prnStr(Uint8List pucStr){
    return SmartpospluginPlatform.instance.sdkPrnStr(pucStr);
  }


  Future<String> getPrnStatus(){

    return SmartpospluginPlatform.instance.getPrinterStatus();

  }

  Future<String> printEpson(Uint8List pucStr){
    return SmartpospluginPlatform.instance.printEpson(pucStr);
  }




  Future<String> separateOnlineResp(String pucStr){
    return SmartpospluginPlatform.instance.separateOnlineResp(pucStr);
  }


  Future<String> pinPadUpMastKey(int keynum,String ckeyStr)  {

    return SmartpospluginPlatform.instance.pinPadUpMastKey(keynum,ckeyStr);
  }

  Future<String> pinPadUpWorkKey(int keynum,String pin_keystr, String mac_keystr,String tdk_keystr) {

    return SmartpospluginPlatform.instance.pinPadUpWorkKey(keynum,pin_keystr,mac_keystr,tdk_keystr);
  }


  Future<String> charEncode(String ckeyStr,String format) {

    return  SmartpospluginPlatform.instance.charEncode(ckeyStr, format);
  }


  Future<String> setFontLib(int codePage)  {

    return  SmartpospluginPlatform.instance.setFontLib(codePage);
  }

  Future<String> onlinePinPad(String pan)  {

    return  SmartpospluginPlatform.instance.onlinePinPad(pan);
  }


}
