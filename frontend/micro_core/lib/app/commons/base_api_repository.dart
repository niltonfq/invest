import 'package:commons_deps/commons_deps.dart';
import 'package:micro_core/app/http/http_get.dart';

class BaseApiRepository {
  Future<void> deleteApi({required String uri}) async {
    HttpGet client = HttpGet();
    try {
      await client.auth().deleteApi(uri);
    } finally {
      client.dispose();
    }
  }

  Future<Response> get({required String uri}) async {
    HttpGet client = HttpGet();
    try {
      var response = await client.auth().getApi(uri);
      return response;
    } finally {
      client.dispose();
    }
  }

  Future<Response> post(
      {required Map<String, dynamic> model, required String uri}) async {
    HttpGet client = HttpGet();
    try {
      return await client.auth().postApi(uri, data: model);
    } finally {
      client.dispose();
    }
  }

  Future<Response> put(
      {required Map<String, dynamic> model, required String uri}) async {
    HttpGet client = HttpGet();
    try {
      return await client.auth().putApi(uri, data: model);
    } finally {
      client.dispose();
    }
  }
}
