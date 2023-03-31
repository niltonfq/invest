

import 'package:micro_core/micro_core.dart';

import 'segmento_repository.dart';

class SegmentoService extends BaseApiService {
  SegmentoService({required SegmentoRepository repository}) {
    repoApi = repository;
    recurso = '/segmento/';
  }

 
}
