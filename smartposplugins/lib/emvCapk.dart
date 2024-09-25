/**
 * 文件名：[EmvCapk]
 * 作者：[alex]
 * 创建时间：[20230707]
 * 文件描述：[]
 */


class EmvCapk {

   String _rid=""; 		//9F06 与认证中心公钥索引一起标识认证中心的公钥
   int _keyID=0; 		//9F22 认证中心公钥索引
   int _hashIndicator=0; //DF06 认证中心公钥哈什算法标识
   int _capkIndicator=0; //DF07 认证中心公钥算法标识
   String _modul=""; 		//DF02 认证中心公钥模   变长，最大为248
   String _exponent=""; 	//DF04 认证中心公钥指数  0x10001或0x03
   String _expDate=""; 	//DF05 认证中心公钥有效期(bcd yyyymmdd)
   String _checkSum=""; 	//DF03 认证中心公钥校验值sha1



   String getRID() {
    return _rid;
  }

   void setRID(String rid) {
    _rid = rid;
  }

  int getKeyID() {
    return _keyID;
  }

   void setKeyID(int keyID) {
    _keyID = keyID;
  }

  int getHashIndicator() {
    return _hashIndicator;
  }

   void setHashIndicator(int hashIndicator) {
    _hashIndicator = hashIndicator;
  }

 int getCapkIndicator() {
    return _capkIndicator;
  }

   void setCapkIndicator(int capkIndicator) {
    _capkIndicator = capkIndicator;
  }

   String getModul() {
    return _modul;
  }

   void setModul(String modul) {
    _modul = modul;
  }

   String getExponent() {
    return _exponent;
  }

   void setExponent(String exponent) {
    _exponent = exponent;
  }

   String getExpDate() {
    return _expDate;
  }

   void setExpDate(String expDate) {
    _expDate = expDate;
  }

   String getCheckSum() {
     return _checkSum;
  }

   void setCheckSum(String checkSum) {
    _checkSum = checkSum;
  }


}