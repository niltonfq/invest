import 'package:commons_deps/commons_deps.dart';

import '../provento_repository.dart';
import '../provento_service.dart';
import 'provento_controller.dart';

class ProventoBindings implements Bindings {
  @override
  void dependencies() {
    void dependencies() {
      Get.lazyPut(() => ProventoRepository());
      Get.lazyPut(() => ProventoService(repository: Get.find()));
      Get.lazyPut(() => ProventoController(proventoService: Get.find()));
    }
  }
}
