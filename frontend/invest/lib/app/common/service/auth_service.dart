import 'package:commons_deps/commons_deps.dart';
import 'package:micro_core/micro_core.dart';

class AuthService extends GetxService {

  // variáveis
  final _isLogged = RxnBool();
  final _getStorage = GetStorage();
  //

  Future<AuthService> init() async {
    _getStorage.listenKey(CustomConstants.userKey, (value) {
      _isLogged(value != null);
    });

    ever<bool?>(_isLogged, (isLogged) {
      if (isLogged == null || !isLogged) {
        Get.offAllNamed('/login');
        _getStorage.write(CustomConstants.userKey, null);
      } else {
        Get.offAllNamed('/home');
      }
    });

    _isLogged(getUser() != null);
    return this;
  }

   void logout() {
    _getStorage.write(CustomConstants.userKey, null);
    _isLogged(false);
    Get.offAllNamed('/login');
  }

  getUser() => _getStorage.read(CustomConstants.userKey);

  
}
