import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';
import 'package:flutter/material.dart';

import '../banco_model.dart';
import '../banco_service.dart';

class BancoController extends GetxController
    with StateMixin<BancoModel>, LoaderMixin {
  final BancoService _bancoService;
  GlobalKey<FormState> form = GlobalKey();
  BancoController({
    required BancoService bancoService,
  })  : _bancoService = bancoService,
        super();

  // variáveis
  final loading = false.obs;
  Rx<BancoModel> obj = BancoModel().obs;
  final TextEditingController nomeTEC = TextEditingController();
  final TextEditingController cnpjTEC = TextEditingController();
// endRegion variáveis
  @override
  onReady() async {
    try {
      loading(true);

      if (Get.arguments != null) {
        obj.value.id = (Get.arguments as BancoModel).id;
        findOne();
      }
    } catch (e) {
      loading(false);
    }
  }

  Future<void> findOne() async {
    try {
      loading(true);
    } finally {
      loading(false);
    }
  }

  void setEdits() {
    nomeTEC.text = obj.value.nome ?? '';
    cnpjTEC.text = obj.value.cnpj ?? '';
  }

  Future<void> salvar() async {}
}
