import 'package:get/get.dart';

import 'senha_controller.dart';
import 'senha_service.dart';

class SenhaBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SenhaService());
    Get.lazyPut(() => SenhaController());
  }
}
