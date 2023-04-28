import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../carteira_tipo_model.dart';
import '../carteira_tipo_service.dart';

class CarteiraTipoController extends GetxController
    with StateMixin<List<CarteiraTipoModel>>, LoaderMixin {
  final CarteiraTipoService _carteiraTipoService;

  CarteiraTipoController({
    required CarteiraTipoService carteiraTipoService,
  })  : _carteiraTipoService = carteiraTipoService,
        super();
}
