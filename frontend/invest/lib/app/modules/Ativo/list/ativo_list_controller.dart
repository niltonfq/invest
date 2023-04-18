import 'package:commons_design_system/commons_design_system.dart';
import 'package:get/get.dart';

import '../ativo_service.dart';
import '../models/ativo_model.dart';

class AtivoListController extends GetxController
    with StateMixin<List<AtivoModel>> {
  final _isLoading = false.obs;
  get isLoading => _isLoading.value;
  final AtivoService _ativoService;

  AtivoListController({
    required AtivoService ativoService,
  })  : _ativoService = ativoService,
        super();

  @override
  void onReady() async {
    final result = await _ativoService.findAll();
    result.fold(
      (success) {
        change(success, status: RxStatus.success());
        _isLoading(false);
      },
      ((failure) {
        _isLoading(false);
        CustomSnackbar.erro(mensagem: failure.toString());
      }),
    );
    super.onReady();
  }
}
