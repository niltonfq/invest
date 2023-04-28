import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../carteira_model.dart';

class CarteiraListController extends GetxController
    with StateMixin<List<CarteiraModel>>, LoaderMixin {}
