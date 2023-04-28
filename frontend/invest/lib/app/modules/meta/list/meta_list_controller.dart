import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../meta_model.dart';


class MetaListController extends GetxController
    with StateMixin<List<MetaModel>>, LoaderMixin {}
