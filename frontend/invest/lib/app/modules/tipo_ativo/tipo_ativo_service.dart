import 'package:micro_core/micro_core.dart';

import 'tipo_ativo_repository.dart';

class TipoAtivoService extends BaseApiService {
  TipoAtivoService({required TipoAtivoRepository repository}) {
    repoApi = repository;
    recurso = '/tipoAtivo/';
  }
}
