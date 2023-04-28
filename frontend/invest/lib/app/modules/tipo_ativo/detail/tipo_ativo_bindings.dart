import 'package:commons_deps/commons_deps.dart';

import '../tipo_ativo_repository.dart';
import '../tipo_ativo_service.dart';
import 'tipo_ativo_controller.dart';

class TipoAtivoBindings implements Bindings {
  @override
  void dependencies() {
    void dependencies() {
      Get.lazyPut(() => TipoAtivoRepository());
      Get.lazyPut(() => TipoAtivoService(repository: Get.find()));
      Get.lazyPut(() => TipoAtivoController(tipoAtivoService: Get.find()));
    }
  }
}
