import 'dart:async';

import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';
import 'package:flutter/material.dart';

import '../banco_model.dart';
import '../banco_service.dart';

class BancoController extends GetxController
    with StateMixin<BancoModel>, LoaderMixin {
  final BancoService _bancoService;
  final loading = false.obs;
  GlobalKey<FormState> form = GlobalKey();
  final TextEditingController nomeTEC = TextEditingController();
  final TextEditingController cnpjTEC = TextEditingController();

  BancoController({
    required BancoService bancoService,
  })  : _bancoService = bancoService,
        super();

  @override
  onReady() async {
    try {
      loading(true);

      if (Get.arguments != null) {
        findOne(Get.arguments['id']);
      }
    } catch (e) {
      loading(false);
    }
  }

  findOne(String id) async {
    try {
      loading(true);
      
    } finally {
      loading(false);
    }
  }

  void setEdits() {
    nomeTEC.text = value?.nome ?? '';
    cnpjTEC.text = value?.cnpj ?? '';
  }

  Future<void> salvar() async {}
}
