import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../carteira_model.dart';
import '../carteira_service.dart';

class CarteiraListController extends GetxController
    with StateMixin<List<CarteiraModel>>, LoaderMixin {
  final CarteiraService _carteiraService;

  CarteiraListController({
    required CarteiraService carteiraService,
  })  : _carteiraService = carteiraService,
        super();
}
