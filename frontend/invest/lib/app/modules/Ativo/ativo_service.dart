import 'package:micro_core/micro_core.dart';

import 'ativo_repository.dart';

class AtivoService extends BaseApiService {
  AtivoService({required AtivoRepository repository}) {
    repoApi = repository;
    recurso = '/ativo/';
  }
}
