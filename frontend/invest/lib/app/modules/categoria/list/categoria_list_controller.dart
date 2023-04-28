import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../categoria_model.dart';


class CategoriaListController extends GetxController
    with StateMixin<List<CategoriaModel>>, LoaderMixin {}
