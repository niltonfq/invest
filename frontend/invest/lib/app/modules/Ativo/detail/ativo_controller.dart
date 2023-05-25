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
  final _isLoading = false.obs;
  get isLoading => _isLoading.value;

  final TextEditingController codigoTEC = TextEditingController();
  final TextEditingController nomeTEC = TextEditingController();
  final TextEditingController cnpjTEC = TextEditingController();

  final TextEditingController observacaoTEC = TextEditingController();

  final dropOpcoesTA = TipoAtivos.values.map((e) => e.value).toList();
  final dropOpcoesMO = Moeda.values.map((e) => e.value).toList();

  RxList<dynamic> bancos = [].obs;
  RxList<dynamic> segmentos = [].obs;

  AtivoController(
      {required AtivoService ativoService,
      required BancoService bancoService,
      required SegmentoService segmentoService})
      : _ativoService = ativoService,
        _bancoService = bancoService,
        _segmentoService = segmentoService,
        super();

  @override
  onReady() async {
    try {
      _isLoading(true);

      if (Get.arguments != null) {
        findOne(Get.arguments['id']);
      } else {
        change(AtivoModel(), status: RxStatus.success());
      }
    } catch (e) {
      _isLoading(false);
    }
  }

  findOne(String id) async {
    try {
      _isLoading(true);
      final result = await _ativoService
          .find("/" + id + '/usuario/' + EnvironmentConfig.USER);
      result.fold(
        (success) {
          var model = AtivoModel.fromMap(success.body as Map<String, dynamic>);
          change(model, status: RxStatus.success());
          setEdits();
          _isLoading(false);
        },
        ((failure) {
          _isLoading(false);
          CustomSnackbar.erro(mensagem: failure.toString());
        }),
      );
    } finally {
      _isLoading(false);
    }
  }

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
      state?.codigo = codigoTEC.text;
      state?.nome = nomeTEC.text;
      state?.cnpj = cnpjTEC.text;
      state?.observacao = observacaoTEC.text;
    }
  }

  void setEdits() {
    codigoTEC.text = state?.codigo ?? '';
    nomeTEC.text =  state?.nome ?? '' ;
     cnpjTEC.text = state?.cnpj ?? '' ;
     observacaoTEC.text = state?.observacao ?? '';
  }

  Future<void> salvar() async {   
    if (form.currentState!.validate()) {
      getEdits();
      String corpo = state!.toJson();

      final result = _ativoService.saveApi(
          state!.toMap(), 'usuario/' + EnvironmentConfig.USER);
      CustomSnackbar.sucesso('Salvo com sucesso.');
    }

  }

  void atualizarTela() {
    change(state, status: RxStatus.success());
  }
}
