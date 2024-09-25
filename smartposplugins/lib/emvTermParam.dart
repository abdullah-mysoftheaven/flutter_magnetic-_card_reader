/**
 * 文件名：[EmvTermParam]
 * 作者：[alex]
 * 创建时间：[20230707]
 * 文件描述：[]
 */


class EmvTermParam {

    String _ifd = "12345678";
    String _terminalCountry = "0156";
    int _termType = 0x22;
    String _termCapa = "E0E9C8";
    String _addTermCapa = "6000F0A001";
    String _merchantNameLocation = "SZZCS";
    String _merchantCode = "3031";
    String _merchantID = "123456789012345";
    String _acquirerID = "1234567890";
    String _termID = "12345678";
    int _tranRefCurrExp = 0x02;
    String _tranRefCurr = "0156";
    int _tranCurrExp = 0x02;
    String _tranCurrCode = "0156";
    int _termFLmtFlg = 0x01;
    int _rfTxnLmtFlg = 0x01;
    int _rfFLmtFlg = 0x01;
    int _rfCVMLmtFlg = 0x01;
    int _rfStatusCheckFlg = 0x00;
    int _rfZeroAmtNoAllowed = 0x01;



    void setIfd(String ifd){

        _ifd=ifd;
    }
    void setTerminalCountry(String terminalCountry){

        _terminalCountry=terminalCountry;
    }
    void setTermType(int termType){

        _termType=termType;
    }
    void setTermCapa(String termCapa){

        _termCapa=termCapa;
    }
    void setAddTermCapa(String addTermCapa){

        _addTermCapa=addTermCapa;
    }
    void setMerchantNameLocation(String merchantNameLocation){

        _merchantNameLocation=merchantNameLocation;
    }
    void setMerchantCode(String merchantCode){

        _merchantCode=merchantCode;
    }
    void setMerchantID(String merchantID){

        _merchantID=merchantID;
    }
    void setAcquirerID(String acquirerID){

        _acquirerID=acquirerID;
    }
    void setTermID(String termID){

        _termID=termID;
    }

    void setTranRefCurrExp(int tranRefCurrExp){

        _tranRefCurrExp=tranRefCurrExp;
    }
    void setTranRefCurr(String tranRefCurr){

        _tranRefCurr=tranRefCurr;
    }
    void setTranCurrExp(int tranCurrExp){

        _tranCurrExp=tranCurrExp;
    }
    void setTranCurrCode(String tranCurrCode){

        _tranCurrCode=tranCurrCode;
    }
    void setTermFLmtFlg(int termFLmtFlg){

        _termFLmtFlg=termFLmtFlg;
    }
    void setRfTxnLmtFlg(int rfTxnLmtFlg){

        _rfTxnLmtFlg=rfTxnLmtFlg;
    }
    void setRfFLmtFlg(int rfFLmtFlg){

        _rfFLmtFlg=rfFLmtFlg;
    }
    void setRfCVMLmtFlg(int rfCVMLmtFlg){

        _rfCVMLmtFlg=rfCVMLmtFlg;
    }
    void setRfStatusCheckFlg(int rfStatusCheckFlg){

        _rfStatusCheckFlg=rfStatusCheckFlg;
    }
    void setRfZeroAmtNoAllowed(int rfZeroAmtNoAllowed){

        _rfZeroAmtNoAllowed=rfZeroAmtNoAllowed;
    }



    String getIfd(){

        return _ifd;
    }
    String getTerminalCountry(){

        return _terminalCountry;
    }
    int getTermType(){

        return _termType;
    }
    String getTermCapa(){

        return _termCapa;
    }
    String getAddTermCapa(){

        return _addTermCapa;
    }
    String getMerchantNameLocation(){

        return _merchantNameLocation;
    }
    String getMerchantCode(){

        return _merchantCode;
    }
    String getMerchantID(){

        return _merchantID;
    }
    String getAcquirerID(){

        return _acquirerID;
    }
    String getTermID(){

        return  _termID;
    }

    int getTranRefCurrExp(){

        return  _tranRefCurrExp;
    }
    String getTranRefCurr(){

        return _tranRefCurr;
    }
    int getTranCurrExp(){

        return  _tranCurrExp;
    }
    String getTranCurrCode(){

        return  _tranCurrCode;
    }
    int getTermFLmtFlg(){

        return  _termFLmtFlg;
    }
    int getRfTxnLmtFlg(){

        return  _rfTxnLmtFlg;
    }
    int getRfFLmtFlg(){

        return  _rfFLmtFlg;
    }
    int getRfCVMLmtFlg(){

        return _rfCVMLmtFlg;
    }
    int getRfStatusCheckFlg(){

        return _rfStatusCheckFlg;
    }
    int getRfZeroAmtNoAllowed(){

       return _rfZeroAmtNoAllowed;
    }

}