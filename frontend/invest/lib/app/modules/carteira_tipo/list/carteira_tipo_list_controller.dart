import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../../carteira_tipo/carteira_tipo_model.dart';


class CarteiraTipoListController extends GetxController
    with StateMixin<List<CarteiraTipoModel>>, LoaderMixin {}