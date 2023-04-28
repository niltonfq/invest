import 'package:commons_deps/commons_deps.dart';

import '../transacao_repository.dart';
import '../transacao_service.dart';
import 'transacao_controller.dart';

class TransacaoBindings implements Bindings {
  @override
  void dependencies() {
    void dependencies() {
      Get.lazyPut(() => TransacaoRepository());
      Get.lazyPut(() => TransacaoService(repository: Get.find()));
      Get.lazyPut(() => TransacaoController(transacaoService: Get.find()));
    }
  }
}
