import 'package:commons_deps/commons_deps.dart';

import '../ativo_questionario_repository.dart';
import '../ativo_questionario_service.dart';
import 'ativo_questionario_list_controller.dart';

class AtivoQuestionarioListBindigs implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AtivoQuestionarioRepository());
    Get.lazyPut(() => AtivoQuestionarioService(repository: Get.find()));
    Get.lazyPut(
      () => AtivoQuestionarioListController(
        ativoQuestionarioService: Get.find(),
      ),
    );
  }
}
