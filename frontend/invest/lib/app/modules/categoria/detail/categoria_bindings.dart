import 'package:commons_deps/commons_deps.dart';

import '../categoria_repository.dart';
import '../categoria_service.dart';
import 'categoria_controller.dart';

class CategoriaBindings implements Bindings {
  @override
  void dependencies() {
    void dependencies() {
      Get.lazyPut(() => CategoriaRepository());
      Get.lazyPut(() => CategoriaService(repository: Get.find()));
      Get.lazyPut(() => CategoriaController(categoriaService: Get.find()));
    }
  }
}
