import 'package:get/get.dart';

import 'percentualInvestimento_repository.dart';
import 'percentualInvestimento_service.dart';
import 'percentualinvestimento_controller.dart';

class PercentualinvestimentoBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PercentualInvestimentoRepository());
    Get.lazyPut(() => PercentualInvestimentoService(repository: Get.find()));
    Get.lazyPut(
      () => PercentualinvestimentoController(
        percentualinvestimentoService: Get.find(),
      ),
    );
  }
}
