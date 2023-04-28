import 'package:commons_deps/commons_deps.dart';

import '../provento_repository.dart';
import '../provento_service.dart';
import 'provento_list_controller.dart';

class ProventoListBindings implements Bindings {
  @override
  void dependencies() {
    void dependencies() {
      Get.lazyPut(() => ProventoRepository());
      Get.lazyPut(() => ProventoService(repository: Get.find()));
      Get.lazyPut(() => ProventoListController(proventoService: Get.find()));
    }
  }
}
