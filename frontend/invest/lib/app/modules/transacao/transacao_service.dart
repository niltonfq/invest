

import 'package:micro_core/micro_core.dart';

import 'transacao_repository.dart';

class TransacaoService extends BaseApiService {
  TransacaoService({required TransacaoRepository repository}) {
    repoApi = repository;
    recurso = '/atransacao/';
  }

 
}
