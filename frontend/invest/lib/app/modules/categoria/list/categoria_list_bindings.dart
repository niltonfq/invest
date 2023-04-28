import 'package:commons_deps/commons_deps.dart';

import '../categoria_repository.dart';
import '../categoria_service.dart';
import 'categoria_list_controller.dart';

class CategoriaListBindings implements Bindings {
  @override
  void dependencies() {
    void dependencies() {
      Get.lazyPut(() => CategoriaRepository());
      Get.lazyPut(() => CategoriaService(repository: Get.find()));
      Get.lazyPut(() => CategoriaListController(categoriaService: Get.find()));
    }
  }
}
