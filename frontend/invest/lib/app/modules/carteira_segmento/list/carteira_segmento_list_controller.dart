import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';

import '../carteira_segmento_model.dart';
import '../carteira_segmento_service.dart';

class CarteiraSegmentoListController extends GetxController
    with StateMixin<List<CarteiraSegmentoModel>>, LoaderMixin {
  final CarteiraSegmentoService _carteiraSegmentoService;

  CarteiraSegmentoListController({
    required CarteiraSegmentoService carteiraSegmentoService,
  })  : _carteiraSegmentoService = carteiraSegmentoService,
        super();
}
