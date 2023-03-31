

import 'package:micro_core/micro_core.dart';

import 'percentualInvestimento_repository.dart';

class PercentualInvestimentoService extends BaseApiService {
  PercentualInvestimentoService({required PercentualInvestimentoRepository repository}) {
    repoApi = repository;
    recurso = '/percentualInvestimento/';
  }

 
}
