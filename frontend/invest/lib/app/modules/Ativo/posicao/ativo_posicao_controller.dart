import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/custom_snackbar.dart';

import '../../tipo_ativo/models/tipo_ativo_view_model.dart';
import '../ativo_service.dart';

class AtivoPosicaoController extends GetxController
    with StateMixin<List<TipoAtivoViewModel>> {
  final _isLoading = false.obs;
  get isLoading => _isLoading.value;
  final totalPatrimonio = "".obs;
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
        somaPatrimonio();
        _isLoading(false);
      },
      ((failure) {
        _isLoading(false);
        CustomSnackbar.erro(mensagem: failure.toString());
      }),
    );
  }

  void somaPatrimonio() {
    totalPatrimonio.value = NumberFormat("R\$ ###,##0.00", 'pt_BR').format(
        state?.fold<double>(
            0,
            (previousValue, element) =>
                previousValue = (previousValue + (element.total ?? 0))));
  }
}
