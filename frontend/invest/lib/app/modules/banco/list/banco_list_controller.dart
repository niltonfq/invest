import 'package:commons_deps/commons_deps.dart';

import '../banco_model.dart';
import '../banco_service.dart';

class BancoListController extends GetxController
    with StateMixin<List<BancoModel>> {
  final BancoService _bancoService;

  BancoListController({
    required BancoService bancoService,
  })  : _bancoService = bancoService,
        super();
}
