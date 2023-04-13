import 'package:get/get.dart';

import 'percentualInvestimento_service.dart';
import 'percentualinvestimento_model.dart';

class PercentualinvestimentoController extends GetxController
    with StateMixin<PercentualinvestimentoModel> {
  final PercentualInvestimentoService _percentualinvestimentoService;

  PercentualinvestimentoController({
    required PercentualInvestimentoService percentualinvestimentoService,
  })  : _percentualinvestimentoService = percentualinvestimentoService,
        super();

  @override
  void onReady() {
    change(PercentualinvestimentoModel(), status: RxStatus.success());
    super.onReady();
  }

  void somaPercent() {
    change(state, status: RxStatus.success());
  }
}
