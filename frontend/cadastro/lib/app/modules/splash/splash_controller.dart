import 'package:commons_deps/commons_deps.dart';
import 'package:micro_core/micro_core.dart';

import '../login/login_service.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    checkLogged();
    super.onReady();
  }

  Future<void> checkLogged() async {
    GetStorage box = GetStorage();
    box.write(CustomConstants.userKey, null);
    await 2.seconds.delay();
    Get.putAsync(() => LoginService().init());
  }
}
