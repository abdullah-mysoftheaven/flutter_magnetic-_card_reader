/**
 * 文件名：[EmvApp]
 * 作者：[alex]
 * 创建时间：[20230707]
 * 文件描述：[]
 */

class EmvApp{

   String _aid="";				//9F06 应用ID
   int _selFlag=0; 			//DF01 应用选择指示符（ASI）(=0部分匹配,=1完全匹配)
   int _targetPer=0; 		//DF17 随机百分比
   int _maxTargetPer=0; 		//DF16 随机最大百分比
   int _floorLimit=0; 		//9F1B 终端最低限额HEX
   int _onLinePINFlag=1;     //DF18 终端联机PIN支持能力(=0不支持,=1支持)
   int _threshold=0; 			//DF15 随机选择阀值
   String _tacDefault="0000000000"; 		//DF11 缺省
   String _tacDenial="0000000000"; 		//DF13 拒绝
   String _tacOnline="0000000000"; 		//DF12 联机
   String _dDOL="0F9F02065F2A029A039C0195059F3704"; 			//DF14 缺省DDOL
   String _tDOL="039F3704"; 			//97     缺省TDOL
   String _version="008C"; 		//9F09 应用版本号
   String _clTransLimit="000100000000";	//DF20 非接最低限额
   String _clOfflineLimit="000100008000";	//DF19 非接脱机最低限额
   String _clCVMLimit="000100000000";		//DF21 非接CVM最低限额
   String _ecTTLVal="000000100000";		//9F7B 电子现金交易限额

    String _acquierId="12345678"; 		//9F01 收单行BCD
    String _merchCateCode="1234";	//9F15 商户类别码
    String _merchId="1234";			// 商户标识 9F16
    String _merName="zcs";			// 商户名称 9F4E
    String _termId="1234";			// 终端标识 9F1C
    String _transCurrCode="0156";	// 交易货币代码 5F2A
    int _transCurrExp=0;		// 交易货币代码指数 5F36
    String _transRefCode="0156";	// 交易货币参考代码 9F3C
    String _transRefExp="0";		// 交易货币参考指数 9F3D
    String _terRisk="1234";			// 终端风险管理数据 9F1D(1~8)

   //PAYPASS-MagStripe--------------------------------
    String _udol="9F6A04";            		//9F69  缺省UDOL
    int _magStripeInd=0;       		//Mag Stripe指示器
    String _magStripeVer="00";            //9F6D Mag Stripe版本
    String _termCapNoCVMReq="E0E9C8";         //NoCVM 终端性能
    String _termCapCVMReq="E0E9C8";           //CVM 终端性能
    String _payPassAddTermCapa="00";      //9F40 终端附加性能
    int _payPassTermType=0x22;		    //9F35 终端类型
    String paypassRFU="00";              //预留


   void setAid(String value) {
    _aid = value;
  }

   void setSelFlag(int value) {
    _selFlag = value;
  }

   void setTargetPer(int value) {
    _targetPer = value;
  }

   void setMaxTargetPer(int value) {
    _maxTargetPer = value;
  }

   void setPayPassTermType(int value) {
    _payPassTermType = value;
  }

   void setPayPassAddTermCapa(String value) {
    _payPassAddTermCapa = value;
  }

   void setTermCapCVMReq(String value) {
    _termCapCVMReq = value;
  }

   void setTermCapNoCVMReq(String value) {
    _termCapNoCVMReq = value;
  }

   void setMagStripeVer(String value) {
    _magStripeVer = value;
  }

   void setMagStripeInd(int value) {
    _magStripeInd = value;
  }

   void setUdol(String value) {
    _udol = value;
  }

   void setTerRisk(String value) {
    _terRisk = value;
  }

   void setTransRefExp(String value) {
    _transRefExp = value;
  }

   void setTransRefCode(String value) {
    _transRefCode = value;
  }

   void setTransCurrExp(int value) {
    _transCurrExp = value;
  }

   void setTransCurrCode(String value) {
    _transCurrCode = value;
  }

   void setTermId(String value) {
    _termId = value;
  }

   void setMerName(String value) {
    _merName = value;
  }

   void setMerchId(String value) {
    _merchId = value;
  }

   void setMerchCateCode(String value) {
    _merchCateCode = value;
  }

   void setAcquierId(String value) {
    _acquierId = value;
  }

   void setEcTTLVal(String value) {
    _ecTTLVal = value;
  }

   void setClCVMLimit(String value) {
    _clCVMLimit = value;
  }

   void setClOfflineLimit(String value) {
    _clOfflineLimit = value;
  }

   void setClTransLimit(String value) {
    _clTransLimit = value;
  }

   void setVersion(String value) {
    _version = value;
  }

   void setTDOL(String value) {
    _tDOL = value;
  }

   void setDDOL(String value) {
    _dDOL = value;
  }

   void setTacOnline(String value) {
    _tacOnline = value;
  }

   void setTacDenial(String value) {
    _tacDenial = value;
  }

   void setTacDefault(String value) {
    _tacDefault = value;
  }

   void setThreshold(int value) {
    _threshold = value;
  }

   void setOnLinePINFlag(int value) {
    _onLinePINFlag = value;
  }

   void setFloorLimit(int value) {
    _floorLimit = value;
  }





   String getAid() {
     return _aid;
   }

   int getSelFlag() {
    return _selFlag;
   }

   int getTargetPer() {

    return  _targetPer ;

   }

   int getMaxTargetPer() {

     return  _maxTargetPer ;

   }

   int getPayPassTermType() {
       return  _payPassTermType ;
   }

   String getPayPassAddTermCapa() {
     return _payPassAddTermCapa;
   }

   String getTermCapCVMReq() {
     return _termCapCVMReq ;
   }

   String getTermCapNoCVMReq() {
     return _termCapNoCVMReq;
   }

   String getMagStripeVer() {
     return _magStripeVer ;
   }

   int getMagStripeInd() {
     return _magStripeInd;
   }

   String getUdol() {
     return _udol;
   }

   String getTerRisk() {
     return _terRisk ;
   }

   String getTransRefExp() {
     return _transRefExp;
   }

   String getTransRefCode() {
     return _transRefCode;
   }

   int getTransCurrExp() {
     return _transCurrExp;
   }

   String getTransCurrCode() {
     return _transCurrCode;
   }

   String getTermId() {
     return  _termId ;
   }

   String getMerName() {
     return  _merName ;
   }

   String getMerchId() {
     return _merchId ;
   }

   String getMerchCateCode() {
     return _merchCateCode ;
   }

   String getAcquierId() {
     return _acquierId;
   }

   String getEcTTLVal() {
     return _ecTTLVal;
   }

   String getClCVMLimit() {
     return _clCVMLimit;
   }

   String getClOfflineLimit() {
     return _clOfflineLimit;
   }

   String getClTransLimit() {
     return _clTransLimit;
   }

   String getVersion() {
     return _version;
   }

   String getTDOL() {
     return _tDOL;
   }

   String getDDOL() {
     return _dDOL;
   }

   String getTacOnline() {
     return _tacOnline;
   }

   String getTacDenial() {
     return  _tacDenial;
   }

   String getTacDefault() {
     return  _tacDefault;
   }

   int getThreshold() {
     return _threshold;
   }

   int getOnLinePINFlag() {
     return _onLinePINFlag;
   }

   int getFloorLimit() {
     return _floorLimit;
   }











// EmvApp(this.aid, this.selFlag, this.targetPer, this.maxTargetPer, this.floorLimit, this.onLinePINFlag,
    //    this.threshold, this.tacDefault, this.tacDenial, this.tacOnline, this.dDOL, this.tDOL,
    //    this.version, this.clTransLimit, this.clOfflineLimit, this.clCVMLimit, this.ecTTLVal,
    //    this.acquierId, this.merchCateCode, this.merchId, this.merName, this.termId, this.transCurrCode,
    //     this.transCurrExp, this.transRefCode, this.transRefExp, this.terRisk){
    //
    //   Smartposplugin smartpos=Smartposplugin.getInstance();
    //
    //
    //   sendJstr=this.aid+";"+this.selFlag+";"+this.targetPer+";"+this.maxTargetPer+";"+this.floorLimit+";"+this.onLinePINFlag+";"+
    //   this.threshold+";"+this.tacDefault+";"+this.tacDenial+";"+this.tacOnline+";"+this.dDOL+";"+this.tDOL+";"+
    //   this.version+";"+this.clTransLimit+";"+this.clOfflineLimit+";"+this.clCVMLimit+";"+this.ecTTLVal+";"+
    //   this.acquierId+";"+this.merchCateCode+";"+this.merchId+";"+this.merName+";"+this.termId+";"+this.transCurrCode+";"+this.transCurrExp+";"+
    //   this.transRefCode+";"+this.transRefExp+";"+this.terRisk+";";
    //
    // }


}