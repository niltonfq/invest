

import 'package:micro_core/micro_core.dart';

import 'home_repository.dart';

class HomeService extends BaseApiService {
  HomeService({required HomeRepository repository}) {
    repoApi = repository;
    recurso = '/home/';
  }

 
}
