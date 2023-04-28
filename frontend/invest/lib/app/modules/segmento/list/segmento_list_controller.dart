import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../segmento_model.dart';
import '../segmento_service.dart';

class SegmentoListController extends GetxController
    with StateMixin<List<SegmentoModel>>, LoaderMixin {
  final SegmentoService _segmentoService;

  SegmentoListController({
    required SegmentoService segmentoService,
  })  : _segmentoService = segmentoService,
        super();
}
