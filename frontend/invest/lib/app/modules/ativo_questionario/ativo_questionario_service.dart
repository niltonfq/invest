

import 'package:micro_core/micro_core.dart';

import 'ativo_questionario_repository.dart';

class AtivoQuestionarioService extends BaseApiService {
  AtivoQuestionarioService({required AtivoQuestionarioRepository repository}) {
    repoApi = repository;
    recurso = '/ativoQuestionario/';
  }

 
}
