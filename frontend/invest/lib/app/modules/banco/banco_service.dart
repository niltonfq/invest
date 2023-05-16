import 'package:commons_deps/commons_deps.dart';
import 'package:micro_core/app/log/log_logger.dart';
import 'package:micro_core/micro_core.dart';

import 'banco_repository.dart';

class BancoService extends BaseApiService {
  final LogLogger _log = LogLogger();
  BancoService({required BancoRepository repository}) {
    repoApi = repository;
    recurso = 'bancos/';
  }

  AsyncResult<Response<dynamic>, Exception> findOne(String id) async {
    try {
      var response = await repoApi.get(
          uri: EnvironmentConfig.SERVER +
              recurso +
              id +
              '/usuario/' +
              EnvironmentConfig.USER);
      if (response.statusCode == 200) {
        return Success(response);
      } else {
        return Failure(
          Exception('Erro ao consultar banco'),
        );
      }
    } catch (e) {
      _log.e(e.toString());
      return Failure(
        Exception('Erro ao consultar banco'),
      );
    }
  }

  AsyncResult<Response<dynamic>, Exception> findAll(
      {int page = 0, String filter = '', String sort = 'nome,ASC'}) async {
    try {
      var response = await repoApi.get(
          uri: EnvironmentConfig.SERVER +
              recurso +
              '/usuario/' +
              EnvironmentConfig.USER +
              '?page=$page&sort=$sort&nome=$filter');
      if (response.statusCode == 200) {
        return Success(response);
      } else {
        return Failure(
          Exception('Erro ao consultar banco'),
        );
      }
    } catch (e) {
      _log.e(e.toString());
      return Failure(
        Exception('Erro ao consultar banco'),
      );
    }
  }
}
