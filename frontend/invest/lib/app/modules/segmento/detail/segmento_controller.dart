import 'dart:async';

import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/commons_design_system.dart';
import 'package:commons_design_system/widgets/commons/loader_mixin.dart';
import 'package:flutter/material.dart';
import 'package:micro_core/micro_core.dart';

import '../segmento_model.dart';
import '../segmento_service.dart';

class SegmentoController extends GetxController
    with StateMixin<SegmentoModel>, LoaderMixin {
  final SegmentoService _segmentoService;
  final _isLoading = false.obs;
  get isLoading => _isLoading.value;
  GlobalKey<FormState> form = GlobalKey();
  final TextEditingController nomeTEC = TextEditingController();
  final TextEditingController cnpjTEC = TextEditingController();

  SegmentoController({
    required SegmentoService segmentoService,
  })  : _segmentoService = segmentoService,
        super();

  @override
  onReady() async {
    try {
      _isLoading(true);

      if (Get.arguments != null) {
        findOne(Get.arguments['id']);
      } else {
        change(SegmentoModel(), status: RxStatus.success());
      }
    } catch (e) {
      _isLoading(false);
    }
  }

  findOne(String id) async {
    try {
      _isLoading(true);
      final result = await _segmentoService
          .find("/" + id + '/usuario/' + EnvironmentConfig.USER);
      result.fold(
        (success) {
          var model =
              SegmentoModel.fromMap(success.body as Map<String, dynamic>);
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
    nomeTEC.text = state?.nome ?? '';
  }

  void getEdits() {
    if (state != null) {
      state?.nome = nomeTEC.text;
    }
  }

  Future<void> salvar() async {
    if (form.currentState!.validate()) {
      getEdits();
      final result = _segmentoService.saveApi(
          state!.toMap(), 'usuario/' + EnvironmentConfig.USER);
      CustomSnackbar.sucesso('Salvo com sucesso.');
    }
  }
}
