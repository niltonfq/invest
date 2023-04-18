import 'package:commons_deps/commons_deps.dart';
import 'package:flutter/material.dart';
import 'package:invest/invest.dart';
import 'package:login/login.dart';
import 'package:micro_core/micro_core.dart';

void main() async {
  await GetStorage.init(CustomConstants.projeto);
  runApp(MyApp());
}

class MyApp extends StatelessWidget with BaseApp {
  MyApp({Key? key}) : super(key: key);

  @override
  List<MicroApp> get microApps => [
        LoginResolver(),
        InvestResolver(),
      ];

  @override
  Widget build(BuildContext context) {
    super.registerRouters();

    return GetMaterialApp(
      title: 'ABS - invest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'OpenSans',
      ),
      navigatorKey: navigatorKey,
      getPages: super.routes,
      initialRoute: '/splash',
    );
  }
}
