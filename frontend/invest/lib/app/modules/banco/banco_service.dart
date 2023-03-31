

import 'package:micro_core/micro_core.dart';

import 'banco_repository.dart';


class BancoService extends BaseApiService {
  BancoService({required BancoRepository repository}) {
    repoApi = repository;
    recurso = '/banco/';
  }
   
}
