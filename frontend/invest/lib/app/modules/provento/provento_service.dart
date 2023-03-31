

import 'package:micro_core/micro_core.dart';

import 'provento_repository.dart';

class ProventoService extends BaseApiService {
  ProventoService({required ProventoRepository repository}) {
    repoApi = repository;
    recurso = '/provento/';
  }

 
}
