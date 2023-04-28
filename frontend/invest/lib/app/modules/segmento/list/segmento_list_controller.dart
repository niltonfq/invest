import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../segmento_model.dart';

class SegmentoListController extends GetxController
    with StateMixin<List<SegmentoModel>>, LoaderMixin {}
