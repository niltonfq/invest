import 'package:commons_deps/commons_deps.dart';

abstract class MicroApp {
  String get microAppName;

  final List<GetPage<dynamic>> routes = [];
}
