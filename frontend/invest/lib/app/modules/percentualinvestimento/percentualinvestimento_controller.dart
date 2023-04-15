import 'package:commons_design_system/commons_design_system.dart';
import 'package:get/get.dart';
import 'package:micro_core/micro_core.dart';

import 'percentualInvestimento_service.dart';
import 'percentualinvestimento_model.dart';

class PercentualinvestimentoController extends GetxController
    with StateMixin<PercentualinvestimentoModel> {
  final PercentualInvestimentoService _percentualinvestimentoService;
  final percentualTotal = 0.obs;

  PercentualinvestimentoController({
    required PercentualInvestimentoService percentualinvestimentoService,
  })  : _percentualinvestimentoService = percentualinvestimentoService,
        super();

  @override
  void onReady() async {
    var response = await _percentualinvestimentoService.getApi(
        uri: EnvironmentConfig.SERVER +
            '/percentualInvestimentos/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c');
    if (response.statusCode == 200) {
      List lista = (response.body['content'] as List);
      var list = PercentualinvestimentoModel.fromJsonList(lista);

      change(list[0], status: RxStatus.success());
    } else {
      change(PercentualinvestimentoModel(), status: RxStatus.success());
    }
    super.onReady();
  }

  void somaPercent() {
    percentualTotal((state?.acoes ?? 0) +
        (state?.fundosImobiliarios ?? 0) +
        (state?.fundosInvestimentos ?? 0) +
        (state?.fiagro ?? 0) +
        (state?.stocks ?? 0) +
        (state?.reits ?? 0) +
        (state?.etfsNacionais ?? 0) +
        (state?.etfsInternacionais ?? 0) +
        (state?.criptoMoedas ?? 0) +
        (state?.tesouroDireto ?? 0) +
        (state?.cdb ?? 0) +
        (state?.lcilca ?? 0) +
        (state?.cricra ?? 0) +
        (state?.debendures ?? 0) +
        (state?.bdrs ?? 0));
    change(state, status: RxStatus.success());
  }

  int? setAcoes(double newValue) => state?.acoes = newValue.round();
  int? setFII(double newValue) => state?.fundosImobiliarios = newValue.round();
  int? setFundosInvestimentos(double newValue) =>
      state?.fundosInvestimentos = newValue.round();
  int? setFiagro(double newValue) => state?.fiagro = newValue.round();
  int? setStocks(double newValue) => state?.stocks = newValue.round();
  int? setReits(double newValue) => state?.reits = newValue.round();
  int? setEtfsNacionais(double newValue) =>
      state?.etfsNacionais = newValue.round();
  int? setEtfsInternacionais(double newValue) =>
      state?.etfsInternacionais = newValue.round();
  int? setCriptomoedas(double newValue) =>
      state?.criptoMoedas = newValue.round();
  int? setTesouroDireto(double newValue) =>
      state?.tesouroDireto = newValue.round();
  int? setCDB(double newValue) => state?.cdb = newValue.round();
  int? setLcilca(double newValue) => state?.lcilca = newValue.round();
  int? setCricra(double newValue) => state?.cricra = newValue.round();
  int? setDebendures(double newValue) => state?.debendures = newValue.round();
  int? setBDRs(double newValue) => state?.bdrs = newValue.round();

  salvar() async {
    if (percentualTotal.value != 100) {
      CustomSnackbar.erro(mensagem: 'Percentual total deve ser 100%');
    }

    Response<dynamic> response;
    if (state?.id == null) {
      response = await _percentualinvestimentoService.saveApi(
        state!.toMap(),
        EnvironmentConfig.SERVER +
            '/percentualInvestimentos/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c',
      );
    } else {
      response = await _percentualinvestimentoService.saveApi(
        state!.toMap(),
        EnvironmentConfig.SERVER +
            '/percentualInvestimentos/' +
            (state?.id ?? '') +
            '/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c',
      );
    }
    if ((response.statusCode != 201) && (response.statusCode != 200)) {
      CustomSnackbar.erro(
        mensagem: (response.statusText ?? '').isEmpty
            ? 'Erro ao salvar'
            : (response.statusText ?? ''),
      );
    }
    CustomSnackbar.sucesso('Registro saldo com sucesso');
  }
}
