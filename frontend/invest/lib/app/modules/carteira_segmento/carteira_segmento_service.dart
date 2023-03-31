



import 'package:micro_core/app/commons/base_api_service.dart';

import 'carteira_segmento_repository.dart';

class CarteiraSegmentgoService extends BaseApiService {
  CarteiraSegmentgoService({required CarteiraSegmentgoRepository repository}) {
    repoApi = repository;
    recurso = '/carteiraSegmentgo/';
  }

 
}
