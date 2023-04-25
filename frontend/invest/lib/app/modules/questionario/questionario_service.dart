import 'package:commons_deps/commons_deps.dart';
import 'package:micro_core/app/log/log_logger.dart';
import 'package:micro_core/micro_core.dart';

import 'questionario_repository.dart';

class QuestionarioService extends BaseApiService {
  
  final LogLogger _log = LogLogger();

  QuestionarioService({required QuestionarioRepository repository}) {
    repoApi = repository;
    recurso = '/questionario/';
  }

  AsyncResult<Response<dynamic>, Exception> findAll(int page) async {
    try {
      var response = await repoApi.get(
        uri: 'http://localhost:8088' +
            recurso +
            '/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c' +
            '?page=$page',
      );
      if (response.statusCode == 200) {
        return Success(response);
      } else {
        return Failure(
          Exception('Erro ao consultar ativos'),
        );
      }
    } catch (e) {
      _log.e(e.toString());
      return Failure(
        Exception('Erro ao consultar ativos'),
      );
    }
  }
}
