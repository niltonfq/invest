import 'package:commons_deps/commons_deps.dart';

import '../segmento_repository.dart';
import '../segmento_service.dart';
import 'segmento_controller.dart';

class SegmentoBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SegmentoRepository());
    Get.lazyPut(() => SegmentoService(repository: Get.find()));
    Get.lazyPut(() => SegmentoController(segmentoService: Get.find()));
  }
}
