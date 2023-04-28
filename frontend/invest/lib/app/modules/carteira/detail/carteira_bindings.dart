import 'package:commons_deps/commons_deps.dart';

import '../carteira_repository.dart';
import '../carteira_service.dart';
import 'carteira_controller.dart';

class CarteiraBindings implements Bindings {
  @override
  void dependencies() {
    void dependencies() {
      Get.lazyPut(() => CarteiraRepository());
      Get.lazyPut(() => CarteiraService(repository: Get.find()));
      Get.lazyPut(() => CarteiraController(carteiraService: Get.find()));
    }
  }
}
