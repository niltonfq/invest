import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../categoria_model.dart';
import '../categoria_service.dart';

class CategoriaController extends GetxController
    with StateMixin<List<CategoriaModel>>, LoaderMixin {
  final CategoriaService _categoriaService;

  CategoriaController({
    required CategoriaService categoriaService,
  })  : _categoriaService = categoriaService,
        super();
}
