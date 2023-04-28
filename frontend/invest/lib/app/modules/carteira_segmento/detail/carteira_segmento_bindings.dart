import 'package:commons_deps/commons_deps.dart';

import '../carteira_segmento_repository.dart';
import '../carteira_segmento_service.dart';
import 'carteira_segmento_controller.dart';

class CarteiraSegmentoSegmentoBindings implements Bindings {
  @override
  void dependencies() {
    void dependencies() {
      Get.lazyPut(() => CarteiraSegmentoRepository());
      Get.lazyPut(() => CarteiraSegmentoService(repository: Get.find()));
      Get.lazyPut(() =>
          CarteiraSegmentoController(carteiraSegmentoService: Get.find()));
    }
  }
}
