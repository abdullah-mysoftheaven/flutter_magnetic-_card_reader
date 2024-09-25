import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:smartposplugin/emvApp.dart';
import 'package:smartposplugin/emvCapk.dart';
import 'package:smartposplugin/emvTermParam.dart';
import 'package:smartposplugin/emvTransParam.dart';
import 'package:smartposplugin/smartposplugin.dart';



class ButtonGrid extends StatefulWidget {
  @override
  _ButtonGridState createState() => _ButtonGridState();
}

class _ButtonGridState extends State<ButtonGrid> {
  String logText  = '';
  String cardText  = '\n\nCard Not Swipe\n\n';

  bool reading=false;
  static const platform = MethodChannel('smartposplugin');
  Smartposplugin  smartpos =Smartposplugin.getInstance();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    platform.setMethodCallHandler((call) async {
      if (call.method == 'onSelApp') {

        platform.invokeMapMethod('messageCall','onSelApp');
        String result = call.arguments;

        String ret='0';

        platform.invokeMapMethod('messageCall','onSelApp:$ret');
        print(result);

      }else if(call.method == 'onConfirmCardNo'){


        String ret='0';

        platform.invokeMapMethod('messageCall','onConfirmCardNo:$ret');

        String result = call.arguments;
        print(result);


      }else if(call.method == 'onInputPIN'){

        platform.invokeMapMethod('messageCall','onInputPIN');
        String result = call.arguments;
        print('receive:'+result);


      }else if(call.method == 'onCertVerify'){

        platform.invokeMapMethod('messageCall','onCertVerify');
        String result = call.arguments;

        String ret='0';
        platform.invokeMapMethod('messageCall','onCertVerify:$ret');
        print('receive:'+result);


      }
      else if(call.method == 'onlineProc'){

        String result = call.arguments;
        print('receive:'+result);

        String respcode='Z1';
        String issuerResp='910AB4E6F3CCEE7C6CA40014';

        String OnlineResp='$respcode;$issuerResp';
        platform.invokeMapMethod('messageCall','onlineProc:$OnlineResp');
      }
      else{
        platform.invokeMapMethod('messageCall','');
      }

    });


  }


  void updateLogText(String text) {
    setState(() {
      cardText= text;
      logText += text + '\n';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sampleApp'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 10, // 按钮之间的水平间隙
              mainAxisSpacing: 10, // 按钮之间的垂直间隙
              children: [
                ElevatedButton(
                  onPressed: () async {
                    reading=false;

                    String res=await smartpos.sysInit();

                    var resp = json.decode(res);

                    if(resp['result']==0){

                      updateLogText('sysinit sucess');
                    }
                    else{

                      updateLogText('sysinit fail ret='+resp['result'].toString());

                    }

                  },
                  child: Text('init'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    reading=false;
                    var res=await smartpos.getFirmwareVer();
                    var resp = json.decode(res);
                    if(resp['result']==0){

                      updateLogText(resp['response']);
                    }
                    else{

                      updateLogText('get ver fail ret='+resp['result'].toString());

                    }







                  },
                  child: Text('version'),
                ),
                ElevatedButton(
                  onPressed: () async {

                    reading=false;
                    String res=await smartpos.getPid();
                    var resp = json.decode(res);
                    if(resp['result']==0){

                      updateLogText(resp['response']);
                    }
                    else{

                      updateLogText('get pid fail ret='+resp['result'].toString());

                    }
                  },
                  child: Text('getpid'),
                ),
                ElevatedButton(
                  onPressed: () {
                    reading=false;
                    printest();

                  },
                  child: Text('printbmp'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    reading=false;


                    String res=await smartpos.getPrnStatus();
                    var resp = json.decode(res);
                    if(resp['result']==0){

                      updateLogText(resp['response']);
                    }
                    else{

                      updateLogText('no papper');
                      return;

                    }

                    String s = "Print font test for factory test\n";


                    smartpos.setFontLib(18);


                    // String utf8String = 'اللغة العربية';
                    String utf8String = 'i Am abdullah \n'
                        ' I am a software developer.';
                       utf8String = cardText;

                    res= await smartpos.charEncode(utf8String, 'windows-1256');

                    resp = json.decode(res);
                    if(resp['result']==0){

                      List<int> intList = List<int>.from(resp['reponsebytes']);

                      Uint8List byteArray = Uint8List.fromList(intList);

                      List<int> bytes = utf8.encode(s);

                      //  byteArray = Uint8List.fromList(bytes);
                      smartpos.prnStr(byteArray);

                    }else{

                      updateLogText('status='+resp['result'].toString());

                    }


                  },
                  child: Text('printstr'),
                ),
                ElevatedButton(
                  onPressed: () async {

                    reading=false;

                    String res=await smartpos.iccRest(0);

                    var resp = json.decode(res);
                    if(resp['result']==0){


                      Uint8List bytes = Uint8List.fromList([0x00,0xA4,0x04,0x00,0x0E,0x31,0x50,0x41,0x59,0x2E,0x53,0x59,0x53,0x2E,0x44,0x44,0x46,0x30,0x31]);
                      res=await smartpos.iccExchangeAPDU(0, bytes);

                      resp = json.decode(res);

                      if(resp['result']==0){

                        updateLogText(resp['response']);

                      }else{

                        updateLogText('IccExchangeAPDU fail'+resp['result'].toString());

                      }

                    }
                    else{

                      updateLogText('iccRest fail'+resp['result'].toString());
                    }
                  },
                  child: Text('iccExchangeApdu'),
                ),
                ElevatedButton(
                  onPressed: () async {

                    reading=false;
                    String res=await smartpos.rfSearchCard(0x01|0x02);

                    var resp = json.decode(res);
                    if(resp['result']==0){

                      res=await smartpos.rfRest();
                      resp = json.decode(res);
                      if(resp['result']==0){

                        Uint8List bytes = Uint8List.fromList([0x00,0xA4,0x04,0x00,0x0E,0x32,0x50,0x41,0x59,0x2E,0x53,0x59,0x53,0x2E,0x44,0x44,0x46,0x30,0x31]);
                        res=await smartpos.rfExchangeAPDU(bytes);

                        resp = json.decode(res);
                        if(resp['result']==0){

                          updateLogText(resp['response']);

                        }
                        else{

                          updateLogText('rfExchangeAPDU fail'+resp['result'].toString());

                        }
                      }else{

                        updateLogText('rf reset fail');

                      }


                    }else{

                      updateLogText('rf search fail');
                    }

                  },
                  child: Text('rfExchangeApdu'),
                ),

                ElevatedButton(
                  onPressed: () async {

                    updateWorkKey();


                    // showDialogFunction(context);

                  },
                  child: Text('updateWorkey'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Set the background color here
                  ),
                  onPressed: () async {

                    if( reading){

                      updateLogText('Card Reading pleas wait');

                      return;
                    }

                    updateLogText('please swipe card');
                    reading=true;
                    ReadBankCard(5000);


                    // showDialogFunction(context);

                  },
                  child: Text('Read Bank Card',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,

                        fontSize: 15,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(

            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 20,right: 20),
              child: Text(logText,textAlign: TextAlign.center),
               ),

            ),
          ),
        ],
      ),
    );
  }



  Future<Uint8List> loadImageData(String imagePath) async {
    final ByteData byteData = await rootBundle.load(imagePath);
    return byteData.buffer.asUint8List();
  }


  Future<void> printest() async {


    Uint8List imageData = await loadImageData('images/print_demo.bmp');


    String res=await smartpos.getPrnStatus();

    var resp = json.decode(res);

    if(resp['result']==0){

      updateLogText(resp['response']);
    }
    else{

      updateLogText('no papper result='+resp['result'].toString());
      return;

    }

    String st=await smartpos.prnBitmap(imageData);

  }



  Future<void> updateWorkKey() async {

    //处理更新工作密钥的操作
    String pin_key = "BF1CA957FE63B286E2134E08A8F3DDA903E0686F";
    String mac_key = "8670685795c8d2ea0000000000000000d2db51f1";
    String tdk_key = "00A0ABA733F2CBB1E61535EDCFDC34A93AA3EA2D";

    String mk_key = "31313131313131313232323232323232";





    String res=await smartpos.pinPadUpMastKey(0, mk_key);
    var resp = json.decode(res);

    if(resp['result']==0){

      print("master key download sucess");

      res=await smartpos.pinPadUpWorkKey(0, pin_key, mac_key, tdk_key);
      resp = json.decode(res);
      if(resp['result']==0){

        updateLogText("work key download sucess");
      }else{

        updateLogText("work key download fail");

      }

    }else{

      updateLogText("master key download fail");

    }

  }


  void loadAmexCapk() {
    EmvCapk ec = EmvCapk();
    ec.setRID("A000000025");
    ec.setKeyID( 0x01);
    ec.setModul("AFAD7010F884E2824650F764D47D7951A16EED6DBB881F384DEDB6702E0FB55C0FBEF945A2017705E5286FA249A591E194BDCD74B21720B44CE986F144237A25F95789F38B47EA957F9ADB2372F6D5D41340A147EAC2AF324E8358AE1120EF3F");
    ec.setExponent("03");
    ec.setExpDate("20491231");// YYMMDD
    ec.setCheckSum("ACFE734CF09A84C7BF025F0FFC6FA8CA25A22869");
    smartpos.addCapk(ec);
    ec = EmvCapk();
    ec.setRID("A000000025");
    ec.setKeyID(0x02);
    ec.setModul("AF4B8D230FDFCB1538E975795A1DB40C396A5359FAA31AE095CB522A5C82E7FFFB252860EC2833EC3D4A665F133DD934EE1148D81E2B7E03F92995DDF7EB7C90A75AB98E69C92EC91A533B21E1C4918B43AFED5780DE13A32BBD37EBC384FA3DD1A453E327C56024DACAEA74AA052C4D");
    ec.setExponent("03");
    ec.setExpDate("20491231");// YYMMDD
    ec.setCheckSum("33F5B0344943048237EC89B275A95569718AEE20");
    smartpos.addCapk(ec);
    ec = EmvCapk();
    ec.setRID("A000000025");
    ec.setKeyID(0x03);
    ec.setModul("B0C2C6E2A6386933CD17C239496BF48C57E389164F2A96BFF133439AE8A77B20498BD4DC6959AB0C2D05D0723AF3668901937B674E5A2FA92DDD5E78EA9D75D79620173CC269B35F463B3D4AAFF2794F92E6C7A3FB95325D8AB95960C3066BE548087BCB6CE12688144A8B4A66228AE4659C634C99E36011584C095082A3A3E3");
    ec.setExponent("03");
    ec.setExpDate("20491231");// YYMMDD
    ec.setCheckSum("8708A3E3BBC1BB0BE73EBD8D19D4E5D20166BF6C");
    smartpos.addCapk(ec);
    ec = EmvCapk();
    ec.setRID("A000000025");
    ec.setKeyID(0x0E);
    ec.setModul("AA94A8C6DAD24F9BA56A27C09B01020819568B81A026BE9FD0A3416CA9A71166ED5084ED91CED47DD457DB7E6CBCD53E560BC5DF48ABC380993B6D549F5196CFA77DFB20A0296188E969A2772E8C4141665F8BB2516BA2C7B5FC91F8DA04E8D512EB0F6411516FB86FC021CE7E969DA94D33937909A53A57F907C40C22009DA7532CB3BE509AE173B39AD6A01BA5BB85");
    ec.setExponent("03");
    ec.setExpDate("20491231");// YYMMDD
    ec.setCheckSum("A7266ABAE64B42A3668851191D49856E17F8FBCD");
    smartpos.addCapk(ec);
    ec = EmvCapk();
    ec.setRID("A000000025");
    ec.setKeyID(0x0F);
    ec.setModul("C8D5AC27A5E1FB89978C7C6479AF993AB3800EB243996FBB2AE26B67B23AC482C4B746005A51AFA7D2D83E894F591A2357B30F85B85627FF15DA12290F70F05766552BA11AD34B7109FA49DE29DCB0109670875A17EA95549E92347B948AA1F045756DE56B707E3863E59A6CBE99C1272EF65FB66CBB4CFF070F36029DD76218B21242645B51CA752AF37E70BE1A84FF31079DC0048E928883EC4FADD497A719385C2BBBEBC5A66AA5E5655D18034EC5");
    ec.setExponent("03");
    ec.setExpDate("20491231");// YYMMDD
    ec.setCheckSum("A73472B3AB557493A9BC2179CC8014053B12BAB4");
    smartpos.addCapk(ec);
    ec = EmvCapk();
    ec.setRID("A000000025");
    ec.setKeyID(0x10);
    ec.setModul("CF98DFEDB3D3727965EE7797723355E0751C81D2D3DF4D18EBAB9FB9D49F38C8C4A826B99DC9DEA3F01043D4BF22AC3550E2962A59639B1332156422F788B9C16D40135EFD1BA94147750575E636B6EBC618734C91C1D1BF3EDC2A46A43901668E0FFC136774080E888044F6A1E65DC9AAA8928DACBEB0DB55EA3514686C6A732CEF55EE27CF877F110652694A0E3484C855D882AE191674E25C296205BBB599455176FDD7BBC549F27BA5FE35336F7E29E68D783973199436633C67EE5A680F05160ED12D1665EC83D1997F10FD05BBDBF9433E8F797AEE3E9F02A34228ACE927ABE62B8B9281AD08D3DF5C7379685045D7BA5FCDE58637");
    ec.setExponent("03");
    ec.setExpDate("20491231");// YYMMDD
    ec.setCheckSum("C729CF2FD262394ABC4CC173506502446AA9B9FD");
    smartpos.addCapk(ec);
    ec =  EmvCapk();
    ec.setRID("A000000025");
    ec.setKeyID(0x52);
    ec.setModul("CF98DFEDB3D3727965EE7797723355E0751C81D2D3DF4D18EBAB9FB9D49F38C8C4A826B99DC9DEA3F01043D4BF22AC3550E2962A59639B1332156422F788B9C16D40135EFD1BA94147750575E636B6EBC618734C91C1D1BF3EDC2A46A43901668E0FFC136774080E888044F6A1E65DC9AAA8928DACBEB0DB55EA3514686C6A732CEF55EE27CF877F110652694A0E3484C855D882AE191674E25C296205BBB599455176FDD7BBC549F27BA5FE35336F7E29E68D783973199436633C67EE5A680F05160ED12D1665EC83D1997F10FD05BBDBF9433E8F797AEE3E9F02A34228ACE927ABE62B8B9281AD08D3DF5C7379685045D7BA5FCDE58637");
    ec.setExponent("010001");
    ec.setExpDate("20491231");// YYMMDD
    ec.setCheckSum("C729CF2FD262394ABC4CC173506502446AA9B9FD");
    smartpos.addCapk(ec);
    ec =  EmvCapk();
    ec.setRID("A000000025");
    ec.setKeyID(0xA1);
    ec.setModul("99D17396421EE3F919BA549D9554BE0D4F92CB8B53B4878ED60CC5B2DEEDC79B85C8BD6FD2F23C22E68B381AEEB74153AFB3C96E6C96AD018E73C2025D1EE77622A72BEE973C1AF7B908468D74FDB53DCE8380523E38C30D0A8A226529726824E209E668F49F43B0E8CD2FE527CE7CC41F33F434F95D6E2FE2F589372032F2D6504340F8C542D298B499A53D95AF4083");
    ec.setExponent("010001");
    ec.setExpDate("20491231");// YYMMDD
    ec.setCheckSum("BBB9ABE889611198C387B5B0AB374934BC2B2EA9");
    smartpos.addCapk(ec);
    ec =  EmvCapk();
    ec.setRID("A000000025");
    ec.setKeyID(0x99);
    ec.setModul("E1740074229FA0D228A9623581D7A322903FB89BA7686712E601FA8AB24A9789186F15B70CCBBE7421B1CB110D45361688135FFD0DB15A3F516BB291D4A123EBF5A06FBF7E1EE6311B737DABB289570A7959D532B25F1DA6758C84DDCCADC049BC764C05391ABD2CADEFFA7E242D5DD06E56001F0E68151E3388074BD9330D6AFA57CBF33946F531E51E0D4902EE235C756A905FB733940E6EC897B4944A5EDC765705E2ACF76C78EAD78DD9B066DF0B2C88750B8AEE00C9B4D4091FA7338449DA92DBFC908FA0781C0128C492DB993C88BA8BB7CADFE238D477F2517E0E7E3D2B11796A0318CE2AD4DA1DB8E54AB0D94F109DB9CAEEFBEF");
    ec.setExponent("03");
    ec.setExpDate("20491231");// YYMMDD
    ec.setCheckSum("F0885777642C96BB24441FA057AD9A3490763BD2");
    smartpos.addCapk(ec);
    ec =  EmvCapk();
    ec.setRID("A000000025");
    ec.setKeyID(0x98);
    ec.setModul("D31A7094FB221CBA6660FB975AAFEA80DB7BB7EAFD7351E748827AB62D4AEECCFC1787FD47A04699A02DB00D7C382E80E804B35C59434C602389D691B9CCD51ED06BE67A276119C4C10E2E40FC4EDDF9DF39B9B0BDEE8D076E2A012E8A292AF8EFE18553470639C1A032252E0E5748B25A3F9BA4CFCEE073038B061837F2AC1B04C279640F5BD110A9DC665ED2FA6828BD5D0FE810A892DEE6B0E74CE8863BDE08FD5FD61A0F11FA0D14978D8CED7DD3");
    ec.setExponent("03");
    ec.setExpDate("20491231");// YYMMDD
    ec.setCheckSum("D4DBA428CF11D45BAEB0A35CAEA8007AD8BA8D71");
    smartpos.addCapk(ec);
    ec =  EmvCapk();
    ec.setRID("A000000025");
    ec.setKeyID(0x97);
    ec.setModul("E178FFE834B4B767AF3C9A511F973D8E8505C5FCB2D3768075AB7CC946A955789955879AAF737407151521996DFA43C58E6B130EB1D863B85DC9FFB4050947A2676AA6A061A4A7AE1EDB0E36A697E87E037517EB8923136875BA2CA1087CBA7EC7653E5E28A0C261A033AF27E3A67B64BBA26956307EC47E674E3F8B722B3AE0498DB16C7985310D9F3D117300D32B09");
    ec.setExponent("03");
    ec.setExpDate("20491231");// YYMMDD
    ec.setCheckSum("EBDA522B631B3EB4F4CBFC0679C450139D2B69CD");
    smartpos.addCapk(ec);
    ec =  EmvCapk();
    ec.setRID("A000000025");
    ec.setKeyID(0x96);
    ec.setModul("BC9AA294B1FDD263176E3243D8F448BBFFCB6ABD02C31811289F5085A9262B8B1B7C6477EB58055D9EF32A83D1B72D4A1471ECA30CE76585C3FD05372B686F92B795B1640959201523230149118D52D2425BD11C863D9B2A7C4AD0A2BFDBCA67B2713B290F493CD5521E5DDF05EF1040FC238D0A851C8E3E3B2B1F0D5D9D4AED");
    ec.setExponent("03");
    ec.setExpDate("20491231");// YYMMDD
    ec.setCheckSum("E7433E5CFC6001151D8ECD252EBC6E61F7AB2217");
    smartpos.addCapk(ec);
    ec =  EmvCapk();
    ec.setRID("A000000025");
    ec.setKeyID(0x68);
    ec.setModul("F4D198F2F0CF140E4D2D81B765EB4E24CED4C0834822769854D0E97E8066CBE465029B3F410E350F6296381A253BE71A4BBABBD516625DAE67D073D00113AAB9EA4DCECA29F3BB7A5D46C0D8B983E2482C2AD759735A5AB9AAAEFB31D3E718B8CA66C019ECA0A8BE312E243EB47A62300620BD51CF169A9194C17A42E51B34D83775A98E80B2D66F4F98084A448FE0507EA27C905AEE72B62A8A29438B6A4480FFF72F93280432A55FDD648AD93D82B9ECF01275C0914BAD8EB3AAF46B129F8749FEA425A2DCDD7E813A08FC0CA7841EDD49985CD8BC6D5D56F17AB9C67CEC50BA422440563ECCE21699E435C8682B6266393672C693D8B7");
    ec.setExponent("03");
    ec.setExpDate("20491231");// YYMMDD
    ec.setCheckSum("415E5FE9EC966C835FBB3E6F766A9B1A4B8674C3");
    smartpos.addCapk(ec);
    ec = EmvCapk();
    ec.setRID("A000000025");
    ec.setKeyID(0x67);
    ec.setModul("C687ADCCF3D57D3360B174E471EDA693AA555DFDC6C8CD394C74BA25CCDF8EABFD1F1CEADFBE2280C9E81F7A058998DC22B7F22576FE84713D0BDD3D34CFCD12FCD0D26901BA74103D075C664DABCCAF57BF789494051C5EC303A2E1D784306D3DB3EB665CD360A558F40B7C05C919B2F0282FE1ED9BF6261AA814648FBC263B14214491DE426D242D65CD1FFF0FBE4D4DAFF5CFACB2ADC7131C9B147EE791956551076270696B75FD97373F1FD7804F");
    ec.setExponent("03");
    ec.setExpDate("20491231");// YYMMDD
    ec.setCheckSum("52A2907300C8445BF54B970C894691FEADF2D28E");
    smartpos.addCapk(ec);
    ec = EmvCapk();
    ec.setRID("A000000025");
    ec.setKeyID(0x66);
    ec.setModul("BD1478877B9333612D257D9E3C9C23503E28336B723C71F47C25836670395360F53C106FD74DEEEA291259C001AFBE7B4A83654F6E2D9E8148E2CB1D9223AC5903DA18B433F8E3529227505DE84748F241F7BFCD2146E5E9A8C5D2A06D19097087A069F9AE3D610C7C8E1214481A4F27025A1A2EDB8A9CDAFA445690511DB805");
    ec.setExponent("03");
    ec.setExpDate("20491231");// YYMMDD
    ec.setCheckSum("F367CB70F9C9B67B580F533819E302BAC0330090");
    smartpos.addCapk(ec);
    ec = EmvCapk();
    ec.setRID("A000000025");
    ec.setKeyID(0x65);
    ec.setModul("E53EB41F839DDFB474F272CD0CBE373D5468EB3F50F39C95BDF4D39FA82B98DABC9476B6EA350C0DCE1CD92075D8C44D1E57283190F96B3537D9E632C461815EBD2BAF36891DF6BFB1D30FA0B752C43DCA0257D35DFF4CCFC98F84198D5152EC61D7B5F74BD09383BD0E2AA42298FFB02F0D79ADB70D72243EE537F75536A8A8DF962582E9E6812F3A0BE02A4365400D");
    ec.setExponent("03");
    ec.setExpDate("20491231");// YYMMDD
    ec.setCheckSum("894C5D08D4EA28BB79DC46CEAD998B877322F416");
    smartpos.addCapk(ec);
    ec = EmvCapk();
    ec.setRID("A000000025");
    ec.setKeyID(0x64);
    ec.setModul("B0DD551047DAFCD10D9A5E33CF47A9333E3B24EC57E8F066A72DED60E881A8AD42777C67ADDF0708042AB943601EE60248540B67E0637018EEB3911AE9C873DAD66CB40BC8F4DC77EB2595252B61C21518F79B706AAC29E7D3FD4D259DB72B6E6D446DD60386DB40F5FDB076D80374C993B4BB2D1DB977C3870897F9DFA454F5");
    ec.setExponent("03");
    ec.setExpDate("20491231");// YYMMDD
    ec.setCheckSum("792B121D86D0F3A99582DB06974481F3B2E18454");
    smartpos.addCapk(ec);
  }

  List<String> aids=['A000000333010101','A000000333010102','A000000333010103','A000000333010106','A000000333010108','A0000003330101','A00000000305076010','A0000000031010',
    'A000000003101001','A000000003101002','A0000000032010','A0000000032020','A0000000033010','A0000000034010','A0000000035010','A0000000036010','A0000000036020','A0000000038002',
    'A0000000038010','A0000000039010','A000000003999910','A00000000401','A0000000041010','A00000000410101213','A00000000410101215','A0000000042010','A0000000043010','A0000000043060',
    'A000000004306001','A0000000044010','A0000000045010','A0000000046000','A0000000048002','A0000000049999','A0000000050001','A0000000050002','A00000002401','A000000025','A0000000250000',
    'A00000002501','A000000025010402','A000000025010701','A000000025010801','A0000000291010','A0000000421010','A0000000422010','A0000000423010','A0000000424010','A0000000425010',
    'A0000000426010','A00000006510','A0000000651010','A00000006900','A000000077010000021000000000003B','A000000098','A0000000980848','A0000001211010','A0000001410001','A0000001523010',
    'A0000001524010','A0000001544442','A000000172950001','A0000001850002','A0000002281010','A0000002282010','A0000002771010','A00000031510100528','A0000003156020','A0000003591010028001',
    'A0000003710001','A0000004540010','A0000004540011','A0000004766C','A0000005241010','A0000006723010','A0000006723020','A0000007705850','B012345678','D27600002545500100',
    'D5280050218002','D5780000021010','F0000000030001'];


  void loadAids() {
    for (String aid in aids) {
      EmvApp ea =  EmvApp();
      //ea.setAid("A00000000305076010");
      ea.setAid(aid);
      ea.setSelFlag(0);
      ea.setTargetPer( 0x00);
      ea.setMaxTargetPer(0);
      ea.setFloorLimit(1000);
      ea.setOnLinePINFlag(1);
      ea.setThreshold(0);
      ea.setTacDefault("0000000000");
      ea.setTacDenial("0000000000");
      ea.setTacOnline("0000000000");
      ea.setTDOL("0F9F02065F2A029A039C0195059F3704");
      ea.setTDOL("039F3704");
      ea.setVersion("008C");
      ea.setClTransLimit("000100000000");
      ea.setClOfflineLimit("000100008000");
      ea.setClCVMLimit("000100000000");
      ea.setEcTTLVal("000000100000");
      // paypass
      ea.setPayPassTermType(0x22);
      ea.setTermCapNoCVMReq("E0E9C8");
      ea.setTermCapCVMReq("E0E9C8");
      ea.setUdol("9F6A04");
      smartpos.addApp(ea);
    }
  }



  Future<String> emv(int cardtype) async {

    String res="";


    smartpos.emvInit();
    EmvTermParam emvparm =EmvTermParam();
    smartpos.emvTermParamSet(emvparm);
    smartpos.delAllCapk();
    smartpos.delAllAid();
    loadAids();
    loadAmexCapk();
    EmvTransParam emvTransParam = EmvTransParam();
    emvTransParam.setAmountAuth("000000001000");
    smartpos.emvTransParamSet(emvTransParam);


    res=await smartpos.emvTrans(cardtype);

    return res;
  }




  Future<void> ReadBankCard(int timeOut) async {


    smartpos.magOpen();
    smartpos.magOpen();
    smartpos.magClearData();

    int starttime =currentTimeMillis();

    while(reading){

      int endtime =currentTimeMillis();
      if((timeOut!=0)&&(endtime-starttime>=timeOut)){

        updateLogText('time out');
        reading=false;
        break;
      }

      String res= await smartpos.iccGetStatus(0);
      print("res11:: "+res.toString());

      var resp = json.decode(res);
      if(resp['result']==0){

        res= await smartpos.iccRest(0);
        resp = json.decode(res);

        if(resp['result']==0){


          res=await emv(0);
          resp = json.decode(res);
          if(resp['result']==0){


            updateLogText('emvResult:'+resp['EmvResult'].toString()+';'+'response:'+resp['response']);

            break;
          }else{

            updateLogText('emvTrans fail ret='+resp['result'].toString());
            break;

          }



        }else{


          updateLogText('iccRest  rest fail');
          smartpos.iccPowerDown(0);
          break;
        }

      }
      else{

        smartpos.iccPowerDown(0);

        res=await smartpos.rfSearchCard(0x01|0x02);

        print("Pid Data00 ------ $res------");
        resp = json.decode(res);
        if(resp['result']==0){


          res=await smartpos.rfRest();
          resp = json.decode(res);
          if(resp['result']==0){

            res=await emv(1);
            resp = json.decode(res);
            if(resp['result']==0){

              updateLogText('emvResult:'+resp['EmvResult'].toString()+';'+'response:'+resp['response']);
              break;

            }else{

              updateLogText('EmvTrans fail ret='+resp['result'].toString());
              smartpos.rfPowerDown();
              break;

            }
          }else{

            smartpos.rfPowerDown();
            smartpos.iccPowerDown(0);
            updateLogText('RfRest fail');
            break;
          }


        }
        else{

          smartpos.rfPowerDown();


          res=await smartpos.magIfBrush();
         String res22=await smartpos.getPid();
         String res33=await smartpos.getEmvData();
         String res44=await smartpos.getPrnStatus();


         print("Pid Data11 ------ $res------");
         print("Pid Data22 ------ $res22------");
         print("Pid Data33 ------ $res33------");
         print("Pid Data44 ------ $res44------");



          resp = json.decode(res);
          var resp1 = json.decode(res);
          if(resp['result']==0){

            res=await smartpos.magReadData();
            print("card Dataa:: "+res.toString());
            // res=await smartpos.();
            resp = json.decode(res);
            if(resp['result']==0){

              updateLogText(resp['response']);
              print("card Data:: "+resp['response'].toString());
              print("card Data88:: "+resp.toString());
              //updateLogText(resp['Track1']);
              // updateLogText(resp['Track2']);
              //updateLogText(resp['Track3']);



            }
            else{

              updateLogText('magReadData fail:'+resp['response'].toString());

            }

            break;

          }
        }

      }

      sleep(Duration(milliseconds:100));

    }
    reading=false;
    smartpos.magClose();
    smartpos.iccPowerDown(0);
    smartpos.rfPowerDown();
  }

  Future<void> ReadBankCard1(int timeOut) async {


    smartpos.magOpen();
    smartpos.magOpen();
    smartpos.magClearData();

    int starttime =currentTimeMillis();

    while(reading){

      int endtime =currentTimeMillis();
      if((timeOut!=0)&&(endtime-starttime>=timeOut)){

        updateLogText('time out');
        reading=false;
        break;
      }

      String res= await smartpos.iccGetStatus(0);

      var resp = json.decode(res);
      if(resp['result']==0){

        res= await smartpos.iccRest(0);
        resp = json.decode(res);

        if(resp['result']==0){


          res=await emv(0);
          resp = json.decode(res);
          if(resp['result']==0){


            updateLogText('emvResult:'+resp['EmvResult'].toString()+';'+'response:'+resp['response']);

            break;
          }else{

            updateLogText('emvTrans fail ret='+resp['result'].toString());
            break;

          }



        }else{


          updateLogText('iccRest  rest fail');
          smartpos.iccPowerDown(0);
          break;
        }

      }else{

        smartpos.iccPowerDown(0);

        res=await smartpos.rfSearchCard(0x01|0x02);
        resp = json.decode(res);
        if(resp['result']==0){


          res=await smartpos.rfRest();
          resp = json.decode(res);
          if(resp['result']==0){

            res=await emv(1);
            resp = json.decode(res);
            if(resp['result']==0){

              updateLogText('emvResult:'+resp['EmvResult'].toString()+';'+'response:'+resp['response']);
              break;

            }else{

              updateLogText('EmvTrans fail ret='+resp['result'].toString());
              smartpos.rfPowerDown();
              break;

            }
          }else{

            smartpos.rfPowerDown();
            smartpos.iccPowerDown(0);
            updateLogText('RfRest fail');
            break;
          }


        }else{

          smartpos.rfPowerDown();


          res=await smartpos.magIfBrush();
         String res22=await smartpos.getPid();
         String res33=await smartpos.getEmvData();
         String res44=await smartpos.getPrnStatus();

         print("Pid Data22 ------ $res22------");
         print("Pid Data33 ------ $res33------");
         print("Pid Data44 ------ $res44------");



          resp = json.decode(res);
          var resp1 = json.decode(res);
          if(resp['result']==0){

            res=await smartpos.magReadData();
            print("card Dataa:: "+res.toString());
            // res=await smartpos.();
            resp = json.decode(res);
            if(resp['result']==0){

              updateLogText(resp['response']);
              print("card Data:: "+resp['response'].toString());
              //updateLogText(resp['Track1']);
              // updateLogText(resp['Track2']);
              //updateLogText(resp['Track3']);



            }else{

              updateLogText('magReadData fail:'+resp['response'].toString());

            }

            break;

          }
        }

      }

      sleep(Duration(milliseconds:100));

    }
    reading=false;
    smartpos.magClose();
    smartpos.iccPowerDown(0);
    smartpos.rfPowerDown();
  }


  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }


  showDialogFunction(context) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("提示"),
          content: const Text("确定删除吗？"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("取消"),
            ),
            TextButton(onPressed: () {}, child: const Text("确定")),
          ],
        );
      },
    );
  }


}

void main() {
  runApp(MaterialApp(
    home: ButtonGrid(),
  ));
}
