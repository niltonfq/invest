import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../provento_model.dart';


class ProventoListController extends GetxController
    with StateMixin<List<ProventoModel>>, LoaderMixin {}
