import 'package:commons_deps/commons_deps.dart';
import 'package:micro_core/micro_core.dart';

class SenhaService extends GetxService {
  final _isLogged = RxnBool();
  final _getStorage = GetStorage();

  Future<SenhaService> init() async {
    _getStorage.listenKey(CustomConstants.userKey, (value) {
      _isLogged(value != null);
    });

    ever<bool?>(_isLogged, (isLogged) {
      if (isLogged == null || !isLogged) {
        Get.offAllNamed('/senha');
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
    Get.offAllNamed('/senha');
  }

  getUser() => _getStorage.read(CustomConstants.userKey);
}
