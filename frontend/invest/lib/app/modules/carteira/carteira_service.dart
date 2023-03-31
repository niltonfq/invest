import 'package:micro_core/micro_core.dart';

import 'carteira_repository.dart';

class CarteiraService extends BaseApiService {
  CarteiraService({required CarteiraRepository repository}) {
    repoApi = repository;
    recurso = '/carteira/';
  }
}
