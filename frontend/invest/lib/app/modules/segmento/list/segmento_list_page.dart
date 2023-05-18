import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'segmento_list_controller.dart';

class SegmentoListPage extends GetView<SegmentoListController> {
  const SegmentoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<DataColumn> columns = [
      DataColumn(
        label: const Text('Nome'),
        onSort: (columnIndex, ascending) => controller.sort('nome'),
      ),
      DataColumn(
        label: const Text('Cnpj'),
        onSort: (columnIndex, ascending) => controller.sort('cnpj'),
      ),
      const DataColumn(
        label: Text('Ações'),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de segmentos'),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed("/segmento");
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: controller.obx(
        (state) {
          return CustomTabelaPaginada(
            sortAscending: controller.sortAscending,
            columns: columns,
            rows: controller.linhas(),
            primeira: () => controller.setPagina(0),
            anterior: () => controller
                .setPagina(controller.setPagina(controller.pagina - 1)),
            proxima: () => controller
                .setPagina(controller.setPagina(controller.pagina + 1)),
            ultima: () => controller.setPagina(controller.ultimaPagina),
            pagina: controller.pagina,
            totalPaginas:
                (controller.totalItens / controller.totalPorPagina).ceil() - 1,
          );
        },
      ),
    );
  }
}
