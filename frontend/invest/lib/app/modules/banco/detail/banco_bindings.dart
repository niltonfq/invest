import 'package:commons_deps/commons_deps.dart';

import '../banco_repository.dart';
import '../banco_service.dart';
import 'banco_controller.dart';

class BancoBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BancoRepository());
    Get.lazyPut(() => BancoService(repository: Get.find()));
    Get.lazyPut(() => BancoController(bancoService: Get.find()));
  }
}
