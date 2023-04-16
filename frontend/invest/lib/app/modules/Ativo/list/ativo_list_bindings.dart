import 'package:get/get.dart';

import '../ativo_repository.dart';
import '../ativo_service.dart';
import 'ativo_list_controller.dart';



class AtivoListBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AtivoRepository());
    Get.lazyPut(() => AtivoService(repository: Get.find()));
    Get.lazyPut(
      () => AtivoListController(
        ativoService: Get.find(),
      ),
    );
  }
}
