import 'package:commons_deps/commons_deps.dart';

import '../carteira_segmento_repository.dart';
import '../carteira_segmento_service.dart';
import 'carteira_segmento_list_controller.dart';

class CarteiraSegmentoListSegmentoBindings implements Bindings {
  @override
  void dependencies() {
    void dependencies() {
      Get.lazyPut(() => CarteiraSegmentoRepository());
      Get.lazyPut(() => CarteiraSegmentoService(repository: Get.find()));
      Get.lazyPut(() =>
          CarteiraSegmentoListController(carteiraSegmentoService: Get.find()));
    }
  }
}
