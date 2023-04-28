import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../provento_model.dart';
import '../provento_service.dart';

class ProventoController extends GetxController
    with StateMixin<List<ProventoModel>>, LoaderMixin {
  final ProventoService _proventoService;

  ProventoController({
    required ProventoService proventoService,
  })  : _proventoService = proventoService,
        super();
}
