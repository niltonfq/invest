import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

import '../questionario_model.dart';
import 'questionario_controller.dart';

class QuestionarioPage extends GetView<QuestionarioController> {
  const QuestionarioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: 'Questionario',
          ),
          bodyForm(context),
        ],
      ),
    );
  }

  bodyForm(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.form,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: AbsTextFormField(
                    titulo: 'Pergunta',
                    controller: controller.perguntaTEC,
                    validator: Validatorless.required('Campo obrigatório'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                Expanded(
                  child: AbsTextFormField(
                    titulo: 'Critério',
                    controller: controller.criterioTEC,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  onPressed: () async {
                    await controller.salvar();
                    controller.perguntaTEC.text = '';
                    controller.criterioTEC.text = '';
                    controller.obj(QuestionarioModel(
                        tipoAtivo: controller.obj.value.tipoAtivo));
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
