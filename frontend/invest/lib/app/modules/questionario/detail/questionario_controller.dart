import 'package:commons_design_system/widgets/commons/loader_mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:micro_core/app/log/i_log.dart';

import '../questionario_model.dart';
import '../questionario_service.dart';

class QuestionarioController extends GetxController
    with StateMixin<QuestionarioModel>, LoaderMixin {
  final QuestionarioService _questionarioService;

  final loading = false.obs;
  final ILog log = Get.find();
  GlobalKey<FormState> form = GlobalKey();
  Rx<QuestionarioModel> obj = QuestionarioModel().obs;
  final TextEditingController perguntaTEC = TextEditingController();
  final TextEditingController criterioTEC = TextEditingController();
  final TextEditingController tipoAtivoTEC = TextEditingController();

  QuestionarioController({
    required QuestionarioService questionarioService,
  })  : _questionarioService = questionarioService,
        super();

  @override
  onReady() async {
    try {
      loading(true);

      if (Get.arguments != null) {
        obj.value.id = (Get.arguments as QuestionarioModel).id;
        findOne();
      }
    } catch (e) {
      log.e(e.toString());
      loading(false);
    } finally {
      loading(false);
    }
  }

  @override
  void dispose() {
    perguntaTEC.dispose();
    criterioTEC.dispose();
    tipoAtivoTEC.dispose();
    super.dispose();
  }

  Future<void> findOne() async {
    try {
      loading(true);

      setEdits();
    } catch (e) {
      loading(false);
      log.e(e.toString());
    } finally {
      loading(false);
    }
  }

  void setEdits() {
    tipoAtivoTEC.text = '';
    perguntaTEC.text = obj.value.pergunta ?? '';
    criterioTEC.text =
        obj.value.criterio == null ? '' : obj.value.criterio.toString();
  }

  Future<void> salvar() async {
    if (!form.currentState!.validate()) return Future<void>.value();
    obj.value.pergunta = perguntaTEC.text;
    obj.value.criterio = criterioTEC.text;
    obj.value.tipoAtivo = obj.value.tipoAtivo;

    try {} catch (e) {
      log.e(e.toString());
    }
  }
}
