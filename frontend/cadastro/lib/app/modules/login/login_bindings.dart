
import 'package:get/get.dart';

import './login_controller.dart';
import 'login_service.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginService());
    Get.lazyPut(() => LoginController());
  }
}
