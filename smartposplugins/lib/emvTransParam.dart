/**
 * 文件名：[EmvTransParam]
 * 作者：[alex]
 * 创建时间：[20230707]
 * 文件描述：[]
 */

class EmvTransParam {

  int _terminalSupportIndicator = 0x00;				//9F7A 	电子现金终端支持指示器,用于EMV/PBOC中 =0借贷记 =1电子现金 ,qPBOC不用设置
  int _isForceOnline = 0x00;             				//     	是否强制联机, EMV/PBOC =1 强制联机(如余额查询需要);非接 =1 ,如果消费金额<电子现金余额,也执行联机(不走脱机交易)
  String _readerTTQ = "26000080";      				//9F66 	终端交易性能  (如:qPBOC请设置 "26000080")
  String _transNo = "00000001";      					//9F41 	交易流水号(如:"00000001")，用于消费交易，余额查询不用设置
  String _transDate = DateToStr(DateTime.now(),0); //9A   	交易日期  YYMMDD  (如:"180601")
  String _transTime = DateToStr(DateTime.now(), 1); //9F21 	交易时间  HHMMS (如:"120000")
  String _amountAuth = "000000000001";     			//9F02 	授权金额(交易金额) (如:1元表示为"000000000100")
  String _amountOther = "000000000000";    			//9F03 	其他金额(返现金额) (如:0元表示为"000000000000")
  int _transType=0x9C;                 					//9C   交易类型 一般为0x00 ,返现请设置0x14


  void setTerminalSupportIndicator(int terminalSupportIndicator){

    _terminalSupportIndicator=terminalSupportIndicator;
  }

  void setIsForceOnline(int isForceOnline){

    _isForceOnline=isForceOnline;
  }

  void setReaderTTQ(String readerTTQ){

    _readerTTQ=readerTTQ;
  }

  void setTransNo(String transNo){

    _transNo=transNo;
  }

  void setTransDate(String transDate){

    _transDate=transDate;
  }

  void setTransTime(String transTime){

    _transTime=transTime;
  }


  void setAmountAuth(String amountAuth){

    _amountAuth=amountAuth;
  }
  void setAmountOther(String amountOther){

    _amountOther=amountOther;
  }
  void setTransType(int transType){

    _transType=transType;
  }


   int getTerminalSupportIndicator(){

   return _terminalSupportIndicator;
  }

  int getIsForceOnline(){

    return _isForceOnline;
  }


  String getReaderTTQ(){

    return _readerTTQ;
  }

  String getTransNo(){

    return _transNo;
  }

  String getTransDate(){

    return _transDate;
  }

  String getTransTime(){

    return _transTime;
  }


  String getAmountAuth(){

    return _amountAuth;
  }
  String getAmountOther(){

    return _amountOther;
  }
  int getTransType(){

    return _transType;
  }


  static String DateToStr(DateTime now,int formate)
  {
    String formatString="000000";
    if(formate==0) {
         formatString = ('${now.year}').substring(2) +
          ('${now.month}').padLeft(2, '0') + ('${now.day}').padLeft(2, '0');
    }
    else
      {
        formatString = ('${now.hour}').padLeft(2, '0') +
           ('${now.minute}').padLeft(2, '0') + ('${now.second}').padLeft(2, '0');


      }
    return formatString;

  }






}