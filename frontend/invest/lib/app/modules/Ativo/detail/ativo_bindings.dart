import 'package:commons_deps/commons_deps.dart';

import '../ativo_repository.dart';
import '../ativo_service.dart';
import 'ativo_controller.dart';

class AtivoBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AtivoRepository());
    Get.lazyPut(() => AtivoService(repository: Get.find()));
    Get.lazyPut(() => AtivoController(ativoService: Get.find()));
  }
}
