import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ativo_list_controller.dart';

class AtivoListPage extends GetView<AtivoListController> {
  static const double tamanho = 400;

  const AtivoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de ativos'),
      ),
      body: CustomGrid(),
    );
  }
}
