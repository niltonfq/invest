import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../models/tipo_ativo_model.dart';
import '../tipo_ativo_service.dart';



class TipoAtivoController extends GetxController
    with StateMixin<List<TipoAtivoModel>>, LoaderMixin {
  final TipoAtivoService _tipoAtivoService;

  TipoAtivoController({
    required TipoAtivoService tipoAtivoService,
  })  : _tipoAtivoService = tipoAtivoService,
        super();
}
