import 'package:commons_deps/commons_deps.dart';

import '../carteira_tipo_repository.dart';
import '../carteira_tipo_service.dart';
import 'carteira_tipo_controller.dart';

class CarteiraTipoBindings implements Bindings {
  @override
  void dependencies() {
    void dependencies() {
      Get.lazyPut(() => CarteiraTipoRepository());
      Get.lazyPut(() => CarteiraTipoService(repository: Get.find()));
      Get.lazyPut(() =>
          CarteiraTipoController(carteiraTipoService: Get.find()));
    }
  }
}