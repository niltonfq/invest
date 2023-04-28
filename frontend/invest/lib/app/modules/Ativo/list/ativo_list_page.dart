import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ativo_list_controller.dart';

class AtivoListPage extends GetView<AtivoListController> {
  final List<DataColumn> columns = [
    const DataColumn(label: Text('Codigo')),
    const DataColumn(label: Text('Nome')),
  ];
  AtivoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de ativos'),
        actions: [
          IconButton(
              onPressed: () async {
                await Get.toNamed("/banco");
                controller.findAll();
              }, icon:const Icon(Icons.five_k_plus_rounded)),
        ],
      ),
      body: controller.obx(
        (state) {
          return CustomTabelaPaginada(
            columns: columns,
            rows: controller.linhas(),
            primeira: () => controller.setPagina(0),
            anterior: () => controller
                .setPagina(controller.setPagina(controller.pagina - 1)),
            proxima: () => controller
                .setPagina(controller.setPagina(controller.pagina + 1)),
            ultima: () => controller.setPagina(
                controller.ultimaPagina),
            pagina: controller.pagina,
            totalPaginas:
                (controller.totalItens / controller.totalPorPagina).ceil() - 1,
          );
        },
      ),
    );
  }
}
