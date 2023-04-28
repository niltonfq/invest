import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../provento_model.dart';
import '../provento_service.dart';

class ProventoListController extends GetxController
    with StateMixin<List<ProventoModel>>, LoaderMixin {
  final ProventoService _proventoService;

  ProventoListController({
    required ProventoService proventoService,
  })  : _proventoService = proventoService,
        super();
}
