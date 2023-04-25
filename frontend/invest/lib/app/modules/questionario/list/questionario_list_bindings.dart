import 'package:get/get.dart';

import '../questionario_repository.dart';
import '../questionario_service.dart';
import 'questionario_list_controller.dart';



class QuestionarioListBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuestionarioRepository());
    Get.lazyPut(() => QuestionarioService(repository: Get.find()));
    Get.lazyPut(
      () => QuestionarioListController(
        questionarioService: Get.find(),
      ),
    );
  }
}
