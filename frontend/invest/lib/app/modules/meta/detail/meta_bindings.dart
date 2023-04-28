import 'package:commons_deps/commons_deps.dart';

import '../meta_repository.dart';
import '../meta_service.dart';
import 'meta_controller.dart';

class MetaBindings implements Bindings {
  @override
  void dependencies() {
    void dependencies() {
      Get.lazyPut(() => MetaRepository());
      Get.lazyPut(() => MetaService(repository: Get.find()));
      Get.lazyPut(() => MetaController(metaService: Get.find()));
    }
  }
}
