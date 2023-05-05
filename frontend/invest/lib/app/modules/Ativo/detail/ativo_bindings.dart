import 'package:commons_deps/commons_deps.dart';

import '../../banco/banco_repository.dart';
import '../../banco/banco_service.dart';
import '../ativo_repository.dart';
import '../ativo_service.dart';
import 'ativo_controller.dart';

class AtivoBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BancoRepository());
    Get.lazyPut(() => BancoService(repository: Get.find()));
    Get.lazyPut(() => AtivoRepository());
    Get.lazyPut(() => AtivoService(repository: Get.find()));
    Get.lazyPut(() =>
        AtivoController(ativoService: Get.find(), bancoService: Get.find()));
  }
}
