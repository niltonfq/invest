import 'package:get/get.dart';

import '../ativo_repository.dart';
import '../ativo_service.dart';
import 'ativo_posicao_controller.dart';

class AtivoPosicaoBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AtivoRepository());
    Get.put(AtivoService(repository: Get.find()));
    Get.put(AtivoPosicaoController(service: Get.find()));
  }
}
