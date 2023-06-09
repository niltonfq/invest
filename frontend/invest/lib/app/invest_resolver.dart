import 'package:commons_deps/commons_deps.dart';
import 'package:invest/app/modules/segmento/list/segmento_list_page.dart';
import 'package:micro_core/micro_core.dart';

import 'modules/Ativo/detail/ativo_bindings.dart';
import 'modules/Ativo/detail/ativo_page.dart';
import 'modules/Ativo/list/ativo_list_bindings.dart';
import 'modules/Ativo/list/ativo_list_page.dart';
import 'modules/Ativo/posicao/ativo_posicao_bindings.dart';
import 'modules/Ativo/posicao/ativo_posicao_page.dart';
import 'modules/banco/detail/banco_bindings.dart';
import 'modules/banco/detail/banco_page.dart';
import 'modules/banco/list/banco_list_bindigs.dart';
import 'modules/banco/list/banco_list_page.dart';
import 'modules/home/home_bindings.dart';
import 'modules/home/home_page.dart';
import 'modules/percentualinvestimento/percentualinvestimento_bindings.dart';
import 'modules/percentualinvestimento/percentualinvestimento_page.dart';
import 'modules/segmento/detail/segmento_bindings.dart';
import 'modules/segmento/detail/segmento_page.dart';
import 'modules/segmento/list/segmento_list_bindings.dart';

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
          name: '/ativo',
          page: () => AtivoPage(controller: Get.find()),
          binding: AtivoBindings(),
        ),
        GetPage(
          name: '/ativos',
          page: () => AtivoListPage(),
          binding: AtivoListBindings(),
        ),
        GetPage(
          name: '/posicao',
          page: () => AtivoPosicaoPage(controller: Get.find()),
          binding: AtivoPosicaoBindings(),
        ),
        GetPage(
          name: '/percentual',
          page: () => const PercentualinvestimentoPage(),
          binding: PercentualinvestimentoBindings(),
        ),
        GetPage(
          name: '/questionario',
          page: () => const PercentualinvestimentoPage(),
          binding: PercentualinvestimentoBindings(),
        ),
        GetPage(
          name: '/bancos',
          page: () => const BancoListPage(),
          binding: BancoListBindings(),
        ),
        GetPage(
          name: '/banco',
          page: () => const BancoPage(),
          binding: BancoBindings(),
        ),
        GetPage(
          name: '/segmentos',
          page: () => const SegmentoListPage(),
          binding: SegmentoListBindings(),
        ),
        GetPage(
          name: '/segmento',
          page: () => const SegmentoPage(),
          binding: SegmentoBindings(),
        ),
      ];
}
