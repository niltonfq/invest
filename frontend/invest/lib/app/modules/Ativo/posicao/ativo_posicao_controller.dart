import 'package:commons_design_system/widgets/commons/custom_snackbar.dart';
import 'package:invest/app/modules/tipo_ativo/models/tipo_ativo_view_model.dart';

import '../ativo_service.dart';
import 'package:commons_deps/commons_deps.dart';

class AtivoPosicaoController extends GetxController
    with StateMixin<List<TipoAtivoViewModel>> {
  final _isLoading = false.obs;
  get isLoading => _isLoading.value;
  final AtivoService _service;

  AtivoPosicaoController({required AtivoService service})
      : _service = service,
        super();

  @override
  void onReady() async {
    findAll();
    super.onReady();
  }

  findAll() async {
    _isLoading(true);
    
    final result = await _service.findAll();
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
  }
}
