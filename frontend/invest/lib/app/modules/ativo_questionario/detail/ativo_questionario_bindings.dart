import 'package:commons_deps/commons_deps.dart';

import '../ativo_questionario_repository.dart';
import '../ativo_questionario_service.dart';
import 'ativo_questionario_controller.dart';

class AtivoQuestionarioBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AtivoQuestionarioRepository());
    Get.lazyPut(() => AtivoQuestionarioService(repository: Get.find()));
    Get.lazyPut(() =>
        AtivoQuestionarioController(ativoQuestionarioService: Get.find()));
  }
}
