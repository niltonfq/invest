import 'package:get/get.dart';

import 'posicao_controller.dart';
import 'posicao_service.dart';



class ImportBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PosicaoService());
    Get.lazyPut(() => PosicaoController());
  }
}
