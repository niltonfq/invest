import 'package:commons_deps/commons_deps.dart';

import '../banco_repository.dart';
import '../banco_service.dart';
import 'banco_list_controller.dart';

class BancoListBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BancoRepository());
    Get.lazyPut(() => BancoService(repository: Get.find()));
    Get.lazyPut(() => BancoListController(bancoService: Get.find()));
  }
}


