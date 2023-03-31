import 'package:micro_core/micro_core.dart';

import 'carteira_tipo_repository.dart';

class CarteiraTipoService extends BaseApiService {
  CarteiraTipoService({required CarteiraTipoRepository repository}) {
    repoApi = repository;
    recurso = '/carteiraTipo/';
  }
}
