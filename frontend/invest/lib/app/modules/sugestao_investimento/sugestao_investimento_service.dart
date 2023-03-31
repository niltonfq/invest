

import 'package:micro_core/micro_core.dart';

import 'sugestao_investimento_repository.dart';

class SugestaoInvestimentoService extends BaseApiService {
  SugestaoInvestimentoService({required SugestaoInvestimentoRepository repository}) {
    repoApi = repository;
    recurso = '/sugestaoInvestimento/';
  }

 
}
