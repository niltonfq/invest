import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../ativo_questionario_model.dart';
import '../ativo_questionario_service.dart';

class AtivoQuestionarioController extends GetxController
    with StateMixin<AtivoQuestionarioModel>, LoaderMixin {
  final AtivoQuestionarioService _ativoQuestionarioService;

  AtivoQuestionarioController({
    required AtivoQuestionarioService ativoQuestionarioService,
  })  : _ativoQuestionarioService = ativoQuestionarioService,
        super();
}
