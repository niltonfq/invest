import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../transacao_model.dart';
import '../transacao_service.dart';

class TransacaoController extends GetxController
    with StateMixin<List<TransacaoModel>>, LoaderMixin {
  final TransacaoService _transacaoService;

  TransacaoController({
    required TransacaoService transacaoService,
  })  : _transacaoService = transacaoService,
        super();
}
