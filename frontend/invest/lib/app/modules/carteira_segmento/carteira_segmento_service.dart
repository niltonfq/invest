import 'package:micro_core/app/commons/base_api_service.dart';

import 'carteira_segmento_repository.dart';

class CarteiraSegmentoService extends BaseApiService {
  CarteiraSegmentoService({required CarteiraSegmentoRepository repository}) {
    repoApi = repository;
    recurso = '/carteiraSegmento/';
  }
}
