import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';

import 'segmento_controller.dart';

class SegmentoPage extends GetView<SegmentoController> {
  const SegmentoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Corretora / Segmento'),
      ),
      body: bodyForm(),
    );
  }

  bodyForm() {
    return Form(
      key: controller.form,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 40,
          left: 24,
          right: 24,
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    label: 'Segmento',
                    controller: controller.nomeTEC,
                    validator: Validatorless.required('Campo obrigatório'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            CustomButton(
              onPressed: () async {
                await controller.salvar();
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
