import 'package:commons_deps/commons_deps.dart';

import '../ativo_questionario_model.dart';
import '../ativo_questionario_service.dart';

class AtivoQuestionarioListController extends GetxController
    with StateMixin<List<AtivoQuestionarioModel>> {


      final AtivoQuestionarioService _ativoQuestionarioService;

  AtivoQuestionarioListController({
     required AtivoQuestionarioService ativoQuestionarioService,
    }) : _ativoQuestionarioService = ativoQuestionarioService,
    super();
    }
