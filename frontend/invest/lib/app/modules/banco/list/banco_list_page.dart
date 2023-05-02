import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'banco_list_controller.dart';

class BancoListPage extends GetView<BancoListController> {
  final List<DataColumn> columns = [
    const DataColumn(label: Text('Nome')),
    const DataColumn(label: Text('Cnpj')),
  ];
  BancoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de bancos'),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed("/bancoPage");
            },
            icon: const Icon(Icons.add),
          ),
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
