import 'package:get/get.dart';

import './registro_controller.dart';
import 'registro_service.dart';

class RegistroBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegistroService());
    Get.lazyPut(() => RegistroController());
  }
}
