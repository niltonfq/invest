

import 'package:micro_core/micro_core.dart';

import 'questionario_repository.dart';

class QuestionarioService extends BaseApiService {
  QuestionarioService({required QuestionarioRepository repository}) {
    repoApi = repository;
    recurso = '/questionario/';
  }

 
}
