import 'package:commons_deps/commons_deps.dart';

import '../sugestao_investimento_repository.dart';
import '../sugestao_investimento_service.dart';
import 'sugestao_investimento_list_controller.dart';

class SugestaoInvestimentoListBindings implements Bindings {
  @override
  void dependencies() {
    void dependencies() {
      Get.lazyPut(() => SugestaoInvestimentoRepository());
      Get.lazyPut(() => SugestaoInvestimentoService(repository: Get.find()));
      Get.lazyPut(() =>
          SugestaoInvestimentoListController(segmentoService: Get.find()));
    }
  }
}
