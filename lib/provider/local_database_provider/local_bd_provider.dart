
import 'package:flutter/foundation.dart';

import '../../repository/local_repository/share_preferance_repository.dart';
import '../../services/local_service/share_preference.dart';

class LocalDbProvider extends ChangeNotifier{
  final SharePreferanceRepository _sharePreferanceRepository = SharePreferenceService();
   String? _userToken ;

   String? get userToken => _userToken;


  setLoginToken(String userToken) async{
    await _sharePreferanceRepository.setLoginToken(userToken);
     _userToken = await _sharePreferanceRepository.getLoginToken();

  }





}