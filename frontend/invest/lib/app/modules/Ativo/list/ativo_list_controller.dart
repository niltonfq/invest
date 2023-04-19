import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/commons_design_system.dart';

import '../ativo_service.dart';
import '../models/ativo_model.dart';

class AtivoListController extends GetxController
    with StateMixin<List<AtivoModel>> {
  final _isLoading = false.obs;

  get isLoading => _isLoading.value;
  final AtivoService _ativoService;

  final _totalItens = 0.obs;
  get totalItens => _totalItens.value;
  final int totalPorPagina = 10;

  AtivoListController({
    required AtivoService ativoService,
  })  : _ativoService = ativoService,
        super();

  @override
  void onReady() async {
    await findAll(0);
    super.onReady();
  }

  onChangedPage(int page) async {
    int pagina = (page / totalPorPagina).ceil();
    await findAll(pagina);
  }

  Future<void> findAll(int page) async {
    _isLoading(true);
    final result = await _ativoService.findAll(page);
    result.fold(
      (success) {
        List content = (success.body['content'] as List);
        var list = AtivoModel.fromJsonList(content);
        int totalRegistros =
            int.tryParse(success.body['totalElements'].toString()) ?? 0;
        _totalItens(totalRegistros);
        change(list, status: RxStatus.success());
        _isLoading(false);
      },
      ((failure) {
        _isLoading(false);
        CustomSnackbar.erro(mensagem: failure.toString());
      }),
    );
  }
}
