import 'package:get/get.dart';

import '../ativo_service.dart';
import '../models/ativo_model.dart';

class AtivoListController extends GetxController with StateMixin<AtivoModel> {
  final AtivoService _ativoService;

  AtivoListController({
    required AtivoService ativoService,
  })  : _ativoService = ativoService,
        super();
}
