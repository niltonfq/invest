import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:micro_core/micro_core.dart';

import 'modules/login/login_bindings.dart';
import 'modules/login/login_page.dart';
import 'modules/splash/splash_bindings.dart';
import 'modules/splash/splash_page.dart';

class LoginResolver implements MicroApp {
  @override
  String get microAppName => 'login';

  @override
  List<GetPage> get routes => [
    GetPage(
      name: '/splash',
      page: () => const SplashPage(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
      binding: LoginBindings(),
    ),
  ];

      
}
