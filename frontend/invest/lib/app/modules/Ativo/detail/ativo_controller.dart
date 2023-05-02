import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';
import 'package:flutter/material.dart';

import '../../banco/banco_model.dart';
import '../ativo_service.dart';
import '../models/ativo_model.dart';

class AtivoController extends GetxController
    with StateMixin<AtivoModel>, LoaderMixin {
  final TextEditingController bancoTEC = TextEditingController();
  final RxList<BancoModel> bancoList = <BancoModel>[].obs; 
  final AtivoService _ativoService;

  AtivoController({
    required AtivoService ativoService,
  })  : _ativoService = ativoService,
        super();
}
