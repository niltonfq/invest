import 'package:commons_deps/commons_deps.dart';

import '../carteira_repository.dart';
import '../carteira_service.dart';
import 'carteira_list_controller.dart';

class CarteiraListBindings implements Bindings {
  @override
  void dependencies() {
    void dependencies() {
      Get.lazyPut(() => CarteiraRepository());
      Get.lazyPut(() => CarteiraService(repository: Get.find()));
      Get.lazyPut(() => CarteiraListController(carteiraService: Get.find()));
    }
  }
}
