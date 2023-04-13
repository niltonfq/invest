import 'package:commons_deps/commons_deps.dart';
import 'package:micro_core/micro_core.dart';

import 'modules/Ativo/posicao/ativo_posicao_bindings.dart';
import 'modules/Ativo/posicao/ativo_posicao_page.dart';
import 'modules/home/home_bindings.dart';
import 'modules/home/home_page.dart';
import 'modules/percentualinvestimento/percentualinvestimento_bindings.dart';
import 'modules/percentualinvestimento/percentualinvestimento_page.dart';

class InvestResolver implements MicroApp {
  @override
  String get microAppName => "invest";

  @override
  List<GetPage> get routes => [
        GetPage(
          name: '/home',
          page: () => HomePage(controller: Get.find()),
          binding: HomeBindings(),
        ),
        GetPage(
          name: '/posicao',
          page: () => AtivoPosicaoPage(controller: Get.find()),
          binding: AtivoBindings(),
        ),
        GetPage(
          name: '/percentual',
          page: () => const PercentualinvestimentoPage(),
          binding: PercentualinvestimentoBindings(),
        ),
      ];
}
