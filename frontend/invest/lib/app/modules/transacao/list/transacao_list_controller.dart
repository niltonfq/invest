import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../transacao_model.dart';


class TransacaoListController extends GetxController
    with StateMixin<List<TransacaoModel>>, LoaderMixin {}
