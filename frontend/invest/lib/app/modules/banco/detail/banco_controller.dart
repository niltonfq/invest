import 'dart:async';

import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/commons_design_system.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';
import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

import '../banco_model.dart';
import '../banco_service.dart';

class BancoController extends GetxController
    with StateMixin<BancoModel>, LoaderMixin {
  final BancoService _bancoService;
  final _isLoading = false.obs;
  get isLoading => _isLoading.value;
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
      _isLoading(true);

      if (Get.arguments != null) {
        findOne(Get.arguments['id']);
      }
    } catch (e) {
      _isLoading(false);
    }
  }

  findOne(String id) async {
    try {
      _isLoading(true);
      final result = await _bancoService
          .find("/" + id + '/usuario/' + EnvironmentConfig.USER);
      result.fold(
        (success) {
          var model = BancoModel.fromMap(success.body as Map<String, dynamic>);
          change(model, status: RxStatus.success());
          setEdits();
          _isLoading(false);
        },
        ((failure) {
          _isLoading(false);
          CustomSnackbar.erro(mensagem: failure.toString());
        }),
      );
    } finally {
      _isLoading(false);
    }
  }

  void setEdits() {
    nomeTEC.text = value?.nome ?? '';
    cnpjTEC.text = value?.cnpj ?? '';
  }

  Future<void> salvar() async {
    if (form.currentState!.validate()) {
      final result = _bancoService.saveApi(state!.toMap(), 'usuario/'+EnvironmentConfig.USER);
      CustomSnackbar.sucesso('Salvo com sucesso.');
    } 
  }
}
