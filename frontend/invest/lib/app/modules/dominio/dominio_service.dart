

import 'package:micro_core/micro_core.dart';

import 'dominio_repository.dart';

class DominioService extends BaseApiService {
  DominioService({required DominioRepository repository}) {
    repoApi = repository;
    recurso = '/dominio/';
  }

 
}
