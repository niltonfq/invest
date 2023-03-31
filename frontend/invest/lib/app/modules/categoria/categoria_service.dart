import 'package:micro_core/micro_core.dart';

import 'categoria_repository.dart';

class CategoriaService extends BaseApiService {
  CategoriaService({required CategoriaRepository repository}) {
    repoApi = repository;
    recurso = '/categoria/';
  }
}
