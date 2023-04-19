import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/ativo_model.dart';
import 'ativo_list_controller.dart';

class AtivoListPage extends GetView<AtivoListController> {
  static const double tamanho = 400;
  final List<String> colunas = ['Codigo', 'nome', 'moeda'];
  AtivoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de ativos'),
      ),
      body: controller.obx(
        (state) {
          return CustomTabelaPaginada<AtivoModel>(
            colunas: colunas,
            dados: state!,
            totalDeRegistros: controller.totalItens,
            registrosPorPagina: 10,
            onChangedPage: controller.onChangedPage,
            gerarDadosColunas: [
              (dado) => dado.codigo ?? "",
              (dado) => dado.nome ?? "",
              (dado) => dado.moeda ?? "",
            ],
          );
        },
      ),
    );
  }
}
