

import 'package:micro_core/micro_core.dart';

import 'meta_repository.dart';

class MetaService extends BaseApiService {
  MetaService({required MetaRepository repository}) {
    repoApi = repository;
    recurso = '/meta/';
  }

 
}
