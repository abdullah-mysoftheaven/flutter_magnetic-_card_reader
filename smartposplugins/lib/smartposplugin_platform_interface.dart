import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:smartposplugin/emvApp.dart';
import 'package:smartposplugin/emvCapk.dart';

import 'emvTermParam.dart';
import 'emvTransParam.dart';
import 'smartposplugin_method_channel.dart';


///**
/// * 文件名：[smartposplugin_platform_interface]
/// * 作者：[alex]
/// * 创建时间：[20230707]
/// * 文件描述：[]
/// */

abstract class SmartpospluginPlatform extends PlatformInterface {
  /// Constructs a SmartpospluginPlatform.
  SmartpospluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static SmartpospluginPlatform _instance = MethodChannelSmartposplugin();

  /// The default instance of [SmartpospluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelSmartposplugin].
  static SmartpospluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SmartpospluginPlatform] when
  /// they register themselves.
  static set instance(SmartpospluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }


  Future<String>  sysInit()  {
    throw UnimplementedError('sysInit() has not been implemented.');
  }

  Future<String> getSdkVersion(){
    throw UnimplementedError('getSdkVersion() has not been implemented.');
  }

  Future<String> getPid(){

  throw UnimplementedError('getPid() has not been implemented.');
  }

  Future<String> getFirmwareVer(){

    throw UnimplementedError('getSN() has not been implemented.');
  }

  void showLog(int level){
    throw UnimplementedError('getSN() has not been implemented.');
  }


  Future<String> emvTrans(int cardType){

    throw UnimplementedError('EmvTrans() has not been implemented.');
  }

  Future<String> addCapk(EmvCapk capk){

    throw UnimplementedError('addCapk() has not been implemented.');
  }
  Future<String> addApp(EmvApp aid){

    throw UnimplementedError('addAid() has not been implemented.');
  }

  Future<String> delAllCapk(){

    throw UnimplementedError('delAllCapk() has not been implemented.');
  }
  Future<String> delAllAid(){

    throw UnimplementedError('delAllAid() has not been implemented.');
  }


  Future<String> sdkMagOpen(){

    throw UnimplementedError('sdkMagOpen() has not been implemented.');
  }

  Future<String> sdkMagClose(){
    throw UnimplementedError('sdkMagClose() has not been implemented.');
  }

  Future<String> sdkMagIfBrush(){

    throw UnimplementedError('sdkMagIfBrush() has not been implemented.');
  }

  Future<String> sdkMagClearData(){
    throw UnimplementedError('sdkMagClearData() has not been implemented.');
  }


  Future<String> sdkMagParseData(){
    throw UnimplementedError('sdkMagParseData() has not been implemented.');
  }


  Future<String> sdkMagReadData(){
    throw UnimplementedError('sdkMagReadData() has not been implemented.');
  }


  Future<String> sdkIccPowerDown(int ucSlotNo){
    throw UnimplementedError('sdkIccPowerDown() has not been implemented.');
  }

  Future<String> sdkIccGetStatus(int ucSlotNo){
    throw UnimplementedError('sdkIccGetStatus() has not been implemented.');
  }

  Future<String> sdkIccReset(int ucSlotNo){
    throw UnimplementedError('sdkIccReset() has not been implemented.');
  }

  Future<String> sdkIccExchangeAPDU(int ucSlotNo, Uint8List sendApdu){
    throw UnimplementedError('sdkIccExchangeAPDU() has not been implemented.');

  }



  Future<String> sdkRfPowerOn(){
    throw UnimplementedError('sdkRfPowerOn() has not been implemented.');
  }

  Future<String> sdkRfPowerDown(){
    throw UnimplementedError('sdkRfPowerDown() has not been implemented.');
  }


  Future<String> sdkRfSearchCard(int ucInCardType){
    throw UnimplementedError('sdkRfSearchCard() has not been implemented.');
  }


  Future<String> sdkRfExchangeAPDU(Uint8List sendApdu){
  throw UnimplementedError('IccExchangeAPDU() has not been implemented.');
  }

  Future<String> sdkMifVerifyKey(int ucBlock,int ucKeyType, Uint8List pucKey){
   throw UnimplementedError('IccExchangeAPDU() has not been implemented.');
  }

  Future<String> sdkMifReadBlock(int ucBlock){
  throw UnimplementedError('IccExchangeAPDU() has not been implemented.');
  }

  Future<String> sdkMifWriteBlock(int ucBlock, Uint8List pucDataIn){
  throw UnimplementedError('IccExchangeAPDU() has not been implemented.');
  }

  Future<String> sdkMifchangeKey(int ucBlock, int ucKeyType, Uint8List pucKey){
  throw UnimplementedError('sdkMifchangeKey() has not been implemented.');
  }

  Future<String> sdkMifValueOperate(int ucBlock, int type, int value){
    throw UnimplementedError('sdkMifValueOperate() has not been implemented.');
  }
  Future<String> sdkMifReadValue(int ucBlock){
    throw UnimplementedError('sdkMifReadValue() has not been implemented.');
  }


  Future<String> sdkRfCpuReset(){
    throw UnimplementedError('sdkRfCpuReset() has not been implemented.');
  }



  Future<String> sdkPrnSetSpeed(int ucSpeed){
    throw UnimplementedError('sdkPrnSetSpeed() has not been implemented.');
  }
  Future<String> sdkPrnSetGray(int ucgray){
    throw UnimplementedError('sdkPrnSetGray() has not been implemented.');
  }

  Future<String> sdkPrnGetCoverStatus(){
    throw UnimplementedError('sdkPrnGetCoverStatus() has not been implemented.');
  }


  Future<String> sdkPrnSetAlign(int ucAlign){
    throw UnimplementedError('sdkPrnSetAlign() has not been implemented.');
  }

  Future<String> sdkPrnSetFontSize(int ucSize){
    throw UnimplementedError('sdkPrnSetFontSize() has not been implemented.');
  }

  Future<String> sdkPrnSetRowGap(int uiRowGap){
    throw UnimplementedError('sdkPrnSetRowGap() has not been implemented.');
  }

  Future<String> sdkPrnBitmap(Uint8List pucBitmap){
    throw UnimplementedError('sdkPrnBitmap() has not been implemented.');
  }

  Future<String> sdkPrnStr(Uint8List pucStr){
    throw UnimplementedError('sdkPrnStr() has not been implemented.');
  }

  Future<String> sdkPrnPaperForward(int uiDotLine){
    throw UnimplementedError('sdkPrnPaperForward() has not been implemented.');
  }
  Future<String> getEmvData(){

    throw UnimplementedError('sdkPrnPaperForward() has not been implemented.');
  }


  Future<String> getPrinterStatus(){

    throw UnimplementedError('getPrinterStatus() has not been implemented.');
  }

  Future<String> printEpson(Uint8List pucStr)  {

    throw UnimplementedError('printEpson() has not been implemented.');
  }

  Future<String> emvInit() {

    throw UnimplementedError('emvInit() has not been implemented.');
  }

  Future<String> emvTransParamSet(EmvTransParam emvparm) {

    throw UnimplementedError('emvTransParamSet() has not been implemented.');
  }

  Future<String> emvTermParamSet(EmvTermParam emvparm) {
    throw UnimplementedError('emvTermParamSet() has not been implemented.');
  }


  Future<String> separateOnlineResp(String pucStr){
    throw UnimplementedError('emvTermParamSet() has not been implemented.');
  }

  Future<String> pinPadUpMastKey(int keynum,String ckeyStr){
    throw UnimplementedError('pinPadUpMastKey() has not been implemented.');
  }

  Future<String> pinPadUpWorkKey(int keynum,String pin_keystr, String mac_keystr,String tdk_keystr){
    throw UnimplementedError('pinPadUpWorkKey() has not been implemented.');
  }



  Future<String> charEncode(String ckeyStr,String format) async {

    throw UnimplementedError('charEncode() has not been implemented.');
  }

  Future<String> setFontLib(int codePage)  {

    throw UnimplementedError('setFontlib() has not been implemented.');
  }


  Future<String> onlinePinPad(String pan)  {

    throw UnimplementedError('onlinePinPad() has not been implemented.');
  }





}
