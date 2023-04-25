import 'package:get/get.dart';

import '../questionario_repository.dart';
import '../questionario_service.dart';
import 'questionario_controller.dart';

class QuestionarioBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionarioRepository());
    Get.lazyPut(() => QuestionarioService(repository: Get.find()));
    Get.lazyPut(() => QuestionarioController(
          questionarioService: Get.find(),
        ));
  }
}
