import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../meta_model.dart';
import '../meta_service.dart';

class MetaController extends GetxController
    with StateMixin<List<MetaModel>>, LoaderMixin {
  final MetaService _metaService;

  MetaController({
    required MetaService metaService,
  })  : _metaService = metaService,
        super();
}
