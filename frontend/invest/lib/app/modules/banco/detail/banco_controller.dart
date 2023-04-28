import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../banco_model.dart';
import '../banco_service.dart';

class BancoController extends GetxController
    with StateMixin<BancoModel>, LoaderMixin {
  final BancoService _bancoService;

  BancoController({
    required BancoService bancoService,
  })  : _bancoService = bancoService,
        super();
}
