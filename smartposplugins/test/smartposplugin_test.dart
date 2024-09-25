import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:smartposplugin/emvApp.dart';
import 'package:smartposplugin/emvCapk.dart';
import 'package:smartposplugin/emvTermParam.dart';
import 'package:smartposplugin/emvTransParam.dart';
import 'package:smartposplugin/smartposplugin.dart';
import 'package:smartposplugin/smartposplugin_platform_interface.dart';
import 'package:smartposplugin/smartposplugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockSmartpospluginPlatform
    with MockPlatformInterfaceMixin
    implements SmartpospluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<String> emvTrans(int cardType) {
    // TODO: implement emvTrans
    throw UnimplementedError();
  }

  @override
  Future<String> getEmvData() {
    // TODO: implement getEmvData
    throw UnimplementedError();
  }

  @override
  Future<String> getFirmwareVer() {
    // TODO: implement getFirmwareVer
    throw UnimplementedError();
  }

  @override
  Future<String> getPid() {
    // TODO: implement getPid
    throw UnimplementedError();
  }

  @override
  Future<String> getPrinterStatus() {
    // TODO: implement getPrinterStatus
    throw UnimplementedError();
  }

  @override
  Future<String> getSdkVersion() {
    // TODO: implement getSdkVersion
    throw UnimplementedError();
  }

  @override
  Future<String> printEpson(Uint8List pucStr) {
    // TODO: implement printEpson
    throw UnimplementedError();
  }

  @override
  Future<String> sdkIccExchangeAPDU(int ucSlotNo, Uint8List sendApdu) {
    // TODO: implement sdkIccExchangeAPDU
    throw UnimplementedError();
  }

  @override
  Future<String> sdkIccGetStatus(int ucSlotNo) {
    // TODO: implement sdkIccGetStatus
    throw UnimplementedError();
  }

  @override
  Future<String> sdkIccPowerDown(int ucSlotNo) {
    // TODO: implement sdkIccPowerDown
    throw UnimplementedError();
  }

  @override
  Future<String> sdkIccReset(int ucSlotNo) {
    // TODO: implement sdkIccReset
    throw UnimplementedError();
  }

  @override
  Future<String> sdkMagClearData() {
    // TODO: implement sdkMagClearData
    throw UnimplementedError();
  }

  @override
  Future<String> sdkMagClose() {
    // TODO: implement sdkMagClose
    throw UnimplementedError();
  }

  @override
  Future<String> sdkMagIfBrush() {
    // TODO: implement sdkMagIfBrush
    throw UnimplementedError();
  }

  @override
  Future<String> sdkMagOpen() {
    // TODO: implement sdkMagOpen
    throw UnimplementedError();
  }

  @override
  Future<String> sdkMagParseData() {
    // TODO: implement sdkMagParseData
    throw UnimplementedError();
  }

  @override
  Future<String> sdkMagReadData() {
    // TODO: implement sdkMagReadData
    throw UnimplementedError();
  }

  @override
  Future<String> sdkMifReadBlock(int ucBlock) {
    // TODO: implement sdkMifReadBlock
    throw UnimplementedError();
  }

  @override
  Future<String> sdkMifReadValue(int ucBlock) {
    // TODO: implement sdkMifReadValue
    throw UnimplementedError();
  }

  @override
  Future<String> sdkMifValueOperate(int ucBlock, int type, int value) {
    // TODO: implement sdkMifValueOperate
    throw UnimplementedError();
  }

  @override
  Future<String> sdkMifVerifyKey(int ucBlock, int ucKeyType, Uint8List pucKey) {
    // TODO: implement sdkMifVerifyKey
    throw UnimplementedError();
  }

  @override
  Future<String> sdkMifWriteBlock(int ucBlock, Uint8List pucDataIn) {
    // TODO: implement sdkMifWriteBlock
    throw UnimplementedError();
  }

  @override
  Future<String> sdkMifchangeKey(int ucBlock, int ucKeyType, Uint8List pucKey) {
    // TODO: implement sdkMifchangeKey
    throw UnimplementedError();
  }

  @override
  Future<String> sdkPrnBitmap(Uint8List pucBitmap) {
    // TODO: implement sdkPrnBitmap
    throw UnimplementedError();
  }

  @override
  Future<String> sdkPrnGetCoverStatus() {
    // TODO: implement sdkPrnGetCoverStatus
    throw UnimplementedError();
  }

  @override
  Future<String> sdkPrnPaperForward(int uiDotLine) {
    // TODO: implement sdkPrnPaperForward
    throw UnimplementedError();
  }

  @override
  Future<String> sdkPrnSetAlign(int ucAlign) {
    // TODO: implement sdkPrnSetAlign
    throw UnimplementedError();
  }

  @override
  Future<String> sdkPrnSetFontSize(int ucSize) {
    // TODO: implement sdkPrnSetFontSize
    throw UnimplementedError();
  }

  @override
  Future<String> sdkPrnSetGray(int ucgray) {
    // TODO: implement sdkPrnSetGray
    throw UnimplementedError();
  }

  @override
  Future<String> sdkPrnSetRowGap(int uiRowGap) {
    // TODO: implement sdkPrnSetRowGap
    throw UnimplementedError();
  }

  @override
  Future<String> sdkPrnSetSpeed(int ucSpeed) {
    // TODO: implement sdkPrnSetSpeed
    throw UnimplementedError();
  }

  @override
  Future<String> sdkPrnStr(Uint8List pucStr) {
    // TODO: implement sdkPrnStr
    throw UnimplementedError();
  }

  @override
  Future<String> sdkRfCpuReset() {
    // TODO: implement sdkRfCpuReset
    throw UnimplementedError();
  }

  @override
  Future<String> sdkRfExchangeAPDU(Uint8List sendApdu) {
    // TODO: implement sdkRfExchangeAPDU
    throw UnimplementedError();
  }

  @override
  Future<String> sdkRfPowerDown() {
    // TODO: implement sdkRfPowerDown
    throw UnimplementedError();
  }

  @override
  Future<String> sdkRfPowerOn() {
    // TODO: implement sdkRfPowerOn
    throw UnimplementedError();
  }

  @override
  Future<String> sdkRfSearchCard(int ucInCardType) {
    // TODO: implement sdkRfSearchCard
    throw UnimplementedError();
  }

  @override
  void showLog(int level) {
    // TODO: implement showLog
  }

  @override
  Future<String> sysInit() {
    // TODO: implement sysInit
    throw UnimplementedError();
  }

  @override
  Future<String> addApp(EmvApp aid) {
    // TODO: implement addApp
    throw UnimplementedError();
  }

  @override
  Future<String> addCapk(EmvCapk capk) {
    // TODO: implement addCapk
    throw UnimplementedError();
  }

  @override
  Future<String> delAllAid() {
    // TODO: implement delAllAid
    throw UnimplementedError();
  }

  @override
  Future<String> delAllCapk() {
    // TODO: implement delAllCapk
    throw UnimplementedError();
  }

  @override
  Future<String> emvInit() {
    // TODO: implement emvInit
    throw UnimplementedError();
  }

  @override
  Future<String> emvTermParamSet(EmvTermParam emvparm) {
    // TODO: implement emvTermParamSet
    throw UnimplementedError();
  }

  @override
  Future<String> emvTransParamSet(EmvTransParam emvparm) {
    // TODO: implement emvTransParamSet
    throw UnimplementedError();
  }

  @override
  Future<String> pinPadUpMastKey(int keynum, String ckeyStr) {
    // TODO: implement pinPadUpMastKey
    throw UnimplementedError();
  }

  @override
  Future<String> pinPadUpWorkKey(int keynum, String pin_keystr, String mac_keystr, String tdk_keystr) {
    // TODO: implement pinPadUpWorkKey
    throw UnimplementedError();
  }

  @override
  Future<String> separateOnlineResp(String pucStr) {
    // TODO: implement separateOnlineResp
    throw UnimplementedError();
  }

  @override
  Future<String> charEncode(String ckeyStr, String format) {
    // TODO: implement charEncode
    throw UnimplementedError();
  }

  @override
  Future<String> setFontlib(int codePage) {
    // TODO: implement setFonlib
    throw UnimplementedError();
  }
}

void main() {
  final SmartpospluginPlatform initialPlatform = SmartpospluginPlatform.instance;

  test('$MethodChannelSmartposplugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelSmartposplugin>());
  });

  test('getPlatformVersion', () async {
    Smartposplugin smartpospluginPlugin = Smartposplugin.getInstance();
    MockSmartpospluginPlatform fakePlatform = MockSmartpospluginPlatform();
    SmartpospluginPlatform.instance = fakePlatform;

    expect(await smartpospluginPlugin.getPlatformVersion(), '42');
  });
}
