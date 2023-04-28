import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../models/tipo_ativo_model.dart';


class TipoAtivoListController extends GetxController
    with StateMixin<List<TipoAtivoModel>>, LoaderMixin {}
