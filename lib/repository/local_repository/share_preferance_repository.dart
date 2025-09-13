abstract class SharePreferanceRepository{

 Future<void> setLoginToken(String userToken);
 Future<String?> getLoginToken();
 Future<void> deleteToken();



}