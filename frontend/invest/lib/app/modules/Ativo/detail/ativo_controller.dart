import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/commons_design_system.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';
import 'package:flutter/material.dart';
import 'package:invest/app/modules/banco/banco_service.dart';

import '../../banco/banco_model.dart';
import '../ativo_service.dart';
import '../models/ativo_model.dart';

class AtivoController extends GetxController
    with StateMixin<AtivoModel>, LoaderMixin {
  final TextEditingController bancoTEC = TextEditingController();
  final RxList<BancoModel> bancoList = <BancoModel>[].obs; 
  final AtivoService _ativoService;
  final BancoService _bancoService;
  

  List<dynamic> bancos = [];
  RxList<dynamic> ativos = [].obs;


  @override
  void onReady() async {
    carregaBancos();
    carregaAtivos();
    super.onReady();
  }

  AtivoController({
    required AtivoService ativoService,
    required BancoService bancoService,
  })  : _ativoService = ativoService,
        _bancoService = bancoService,
        super();
        
  void carregaBancos() {
    final result = _bancoService.findAll(0);
    result.fold((success) {
      bancos = success.body['content'];
      
    }, (error) => null);
  }
  
  Future<void> carregaAtivos([int paginaAtivo = 0, String filtro = '']) async {
    final result = await _ativoService.findAll(paginaAtivo, 'codigo');
    await result.fold((success) async {
      ativos.addAll(success.body['content']); 
      ativos.refresh();     
    }, (error) => null);
  }

  selecionaAtivo(Map<String, dynamic> obj) {
    AtivoModel ativo = AtivoModel.fromMap(obj);
    
  }
}
