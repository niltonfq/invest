import 'dart:io';

import 'package:commons_deps/commons_deps.dart';

import '../log/i_log.dart';
import '../log/log_logger.dart';

class HttpGet extends GetConnect {
  final ILog _log = LogLogger();
  String _token = '';
  final _timeout = 60;

  HttpGet() {
    onInit();
  }

  void onInit() async {
    httpClient.addRequestModifier<dynamic>((request) {
      final timer = DateTime.now();
      request.headers['start_time'] = timer.toString();

      if (_token != '') {
        request.headers['authorization'] = 'Bearer $_token';
      }
      return request;
    });

    httpClient.timeout = Duration(seconds: _timeout);

    httpClient.addResponseModifier<dynamic>((request, response) {
      if (response.request!.headers['start_time'] != null) {
        final data = response.request!.headers['start_time'];
        final start = DateTime.parse(data!);
        final totalExecution = DateTime.now().difference(start);
        response.request!.headers['execution_time'] =
            totalExecution.inMilliseconds.toString();
      }
      _token = '';
      return response;
    });

    super.onInit();
  }

  HttpGet auth() {
    // var user = Get.find<AuthService>().getUser();
    // _token = user['token'];
    return this;
  }

  void checarTokenInvalido(Response<dynamic> response) {
    // if (response.statusCode == 401) {
    //   Get.find<AuthService>().logout();
    // }
  }

  Future<Response> getApi(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await get(path);
    checarTokenInvalido(response);
    return response;
  }

  Future<Response> postApi(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await post(path, data);
    checarTokenInvalido(response);
    return response;
  }

  Future<Response> putApi(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await put(path, data);
    checarTokenInvalido(response);
    return response;
  }

  Future<Response> deleteApi(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    final response = await delete(path);
    checarTokenInvalido(response);
    return response;
  }

  Future<Response> uploadFileApi(
    String path, {
    required File file,
    required String nome,
  }) async {
    final form = FormData({
      'file': MultipartFile(file, filename: nome),
    });

    final response = await post(path, form);
    checarTokenInvalido(response);
    return response;
  }
}
