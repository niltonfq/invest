import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';
import 'package:flutter/material.dart';

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
  

  RxList<dynamic>bancos = [].obs;
  RxList<dynamic> ativos = [].obs;


  @override
  void onReady() async {   
    change(AtivoModel(), status: RxStatus.success());
    super.onReady();
  }

  AtivoController({
    required AtivoService ativoService,
    required BancoService bancoService,
  })  : _ativoService = ativoService,
        _bancoService = bancoService,
        super();
        
  Future<void> carregaBancos([int pagina = 0, String filtro = '']) async {
    if (pagina == 0){
      bancos.clear();
    }
    final result = _bancoService.findAll(page:pagina, filter: filtro);
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
  
  Future<void> carregaAtivos([int pagina = 0, String filtro = '']) async {
    if (pagina == 0){
      ativos.clear();
    }
    final result = await _ativoService.findAll(pagina, filtro);
    await result.fold((success) async {
      ativos.addAll(success.body['content']); 
      ativos.refresh();     
    }, (error) => null);
  }

  selecionaAtivo(Map<String, dynamic> obj) {
    
    
  }
}
