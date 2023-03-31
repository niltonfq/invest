import 'package:commons_deps/commons_deps.dart';

import 'microapp.dart';

abstract class BaseApp {
  List<MicroApp> get microApps;

  final List<GetPage<dynamic>> routes = [];

  void registerRouters() {
    if (routes.isEmpty) {
      if (microApps.isNotEmpty) {
        for (MicroApp microapp in microApps) {
          routes.addAll(microapp.routes);
        }
      }
    }
  }
}
