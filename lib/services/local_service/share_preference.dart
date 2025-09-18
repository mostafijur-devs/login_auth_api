import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/local_repository/share_preferance_repository.dart';

class SharePreferenceService extends SharePreferanceRepository {
  static const String _tokenKey = 'user_token';

  @override
  Future<void> setLoginToken(String userToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_tokenKey, userToken);
  }

  @override
  Future<String?> getLoginToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  @override
  Future<void> deleteToken()async {
    final prefs = await SharedPreferences.getInstance();

   if(prefs.containsKey(_tokenKey)){
   await prefs.remove(_tokenKey);
   print('delete success');
   }else{
     print('not success');
   }
  }
}

