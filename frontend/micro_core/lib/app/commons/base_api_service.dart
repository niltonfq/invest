import 'package:commons_deps/commons_deps.dart';

import '../../micro_core.dart';
import '../log/log_logger.dart';

class BaseApiService {
  late BaseApiRepository repoApi;
  late String recurso;
  final LogLogger _log = LogLogger();

  AsyncResult<Response<dynamic>, Exception> find(String url) async {
    try {
      var response = await repoApi.get(
          uri: EnvironmentConfig.SERVER +
              recurso +
              url);
      if (response.statusCode == 200) {
        return Success(response);
      } else {
        return Failure(
          Exception('Erro ao consultar, status code: '+response.statusCode.toString()),
        );
      }
    } catch (e) {
      _log.e(e.toString());
      return Failure(
        Exception('Erro ao consultar'),
      );
    }
  }

  Future<void> deleteApi(String? uri) async {
    if (uri == null) {
      uri = EnvironmentConfig.SERVER + recurso;
    }
    await repoApi.deleteApi(uri: uri);
  }

  Future<Response> getApi({String? uri}) async {
    if (uri == null) {
      uri = EnvironmentConfig.SERVER + recurso;
    }
    return await repoApi.get(uri: uri);
  }

  Future<Response> saveApi(Map<String, dynamic> model, String uri) async {
    

    model['id'] = model['id'] ?? 0;

    if (model['id'] == 0) {
      uri = EnvironmentConfig.SERVER + recurso +  uri;
      return await repoApi.post(model: model, uri: uri);
    } else {
      uri = EnvironmentConfig.SERVER + recurso + model['id'] + '/' + uri;
      return await repoApi.put(model: model, uri: uri);
    }
  }
}
