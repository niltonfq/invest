import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../sugestao_investimento_model.dart';
import '../sugestao_investimento_service.dart';

class SugestaoInvestimentoListController extends GetxController
    with StateMixin<List<SugestaoInvestimentoModel>>, LoaderMixin {
  final SugestaoInvestimentoService _segmentoService;

  SugestaoInvestimentoListController({
    required SugestaoInvestimentoService segmentoService,
  })  : _segmentoService = segmentoService,
        super();
}
