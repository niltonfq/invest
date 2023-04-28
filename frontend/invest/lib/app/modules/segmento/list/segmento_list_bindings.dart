import 'package:commons_deps/commons_deps.dart';

import '../segmento_repository.dart';
import '../segmento_service.dart';
import 'segmento_list_controller.dart';

class SegmentoListBindings implements Bindings {
  @override
  void dependencies() {
    void dependencies() {
      Get.lazyPut(() => SegmentoRepository());
      Get.lazyPut(() => SegmentoService(repository: Get.find()));
      Get.lazyPut(() => SegmentoListController(segmentoService: Get.find()));
    }
  }
}
