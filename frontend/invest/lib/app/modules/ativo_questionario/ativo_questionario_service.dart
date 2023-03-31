

import 'package:micro_core/micro_core.dart';

import 'ativo_questionario_repository.dart';

class AtivoFechamentoService extends BaseApiService {
  AtivoFechamentoService({required AtivoFechamentoRepository repository}) {
    repoApi = repository;
    recurso = '/ativoFechamento/';
  }

 
}
