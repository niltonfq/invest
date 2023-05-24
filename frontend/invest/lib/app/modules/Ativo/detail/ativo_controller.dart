import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/custom_snackbar.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';
import 'package:flutter/material.dart';
import 'package:invest/app/enums/moeda.dart';
import 'package:invest/app/modules/segmento/segmento_model.dart';
import 'package:invest/app/modules/segmento/segmento_service.dart';
import 'package:micro_core/micro_core.dart';

import '../../../enums/tipoativo.dart';
import '../../banco/banco_model.dart';
import '../../banco/banco_service.dart';
import '../ativo_service.dart';
import '../models/ativo_model.dart';

class AtivoController extends GetxController
    with StateMixin<AtivoModel>, LoaderMixin {
  final TextEditingController bancoTEC = TextEditingController();
  final RxList<BancoModel> bancoList = <BancoModel>[].obs;
  final AtivoService _ativoService;
  final BancoService _bancoService;
  final SegmentoService _segmentoService;
  GlobalKey<FormState> form = GlobalKey();

  final TextEditingController codigoTEC = TextEditingController();
  final TextEditingController nomeTEC = TextEditingController();
  final TextEditingController cnpjTEC = TextEditingController();
  final TextEditingController quantidadeInicialTEC = TextEditingController();
  final TextEditingController precoTEC = TextEditingController();
  final TextEditingController observacaoTEC = TextEditingController();
  final TextEditingController notaTEC = TextEditingController();
  final dropOpcoesTA = TipoAtivos.values.map((e) => e.value).toList();
  final dropOpcoesMO = Moeda.values.map((e) => e.value).toList();

  RxList<dynamic> bancos = [].obs;
  RxList<dynamic> segmentos = [].obs;

  @override
  void onReady() async {
    change(AtivoModel(), status: RxStatus.success());
    super.onReady();
  }

  AtivoController(
      {required AtivoService ativoService,
      required BancoService bancoService,
      required SegmentoService segmentoService})
      : _ativoService = ativoService,
        _bancoService = bancoService,
        _segmentoService = segmentoService,
        super();

  Future<void> carregaTipoAtivos([int pagina = 0, String filtro = '']) async {}

  Future<void> carregaBancos([int pagina = 0, String filtro = '']) async {
    if (pagina == 0) {
      bancos.clear();
    }
    final result = _bancoService.findAll(page: pagina, filter: filtro);
    result.fold((success) {
      bancos.addAll(success.body['content']);
      bancos.refresh();
    }, (error) => null);
  }

  selecionaBanco(Map<String, dynamic> obj) {
    BancoModel banco = BancoModel.fromMap(obj);
    state?.banco = banco;
    change(state, status: RxStatus.success());
  }

  Future<void> carregaSegmento([int pagina = 0, String filtro = '']) async {
    if (pagina == 0) {
      segmentos.clear();
    }
    final result = _segmentoService.findAll(page: pagina, filter: filtro);
    result.fold((success) {
      segmentos.addAll(success.body['content']);
      segmentos.refresh();
    }, (error) => null);
  }

  selecionaSegmento(Map<String, dynamic> obj) {
    SegmentoModel segmento = SegmentoModel.fromMap(obj);
    state?.segmento = segmento;
    change(state, status: RxStatus.success());
  }

  void getEdits() {
    if (state != null) {
      state?.cnpj = cnpjTEC.text;
      state?.nome = nomeTEC.text;
    }
  }

  Future<void> salvar() async {
    if (form.currentState!.validate()) {
      getEdits();
      final result = _bancoService.saveApi(
          state!.toMap(), 'usuario/' + EnvironmentConfig.USER);
      CustomSnackbar.sucesso('Salvo com sucesso.');
    }
  }

  void atualizarTela() {
    change(state, status: RxStatus.success());
  }
}
