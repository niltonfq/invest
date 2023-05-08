import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';

import 'ativo_controller.dart';

class AtivoPage extends StatelessWidget {
  final AtivoController _controller;
  const AtivoPage({Key? key, required AtivoController controller})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ativo')),
      body: Column(
        children: [
          CustomComboDialog(
            fonteDados: _controller.carregaAtivos,
            chave: 'codigo',
            lista: _controller.ativos,
            titulo: 'Ativos',
            onTap: _controller.selecionaAtivo,
            valorAtual: 'PTBR',
            addNovo: () async => await Get.toNamed('/ativos'),
            label: 'ativo',
          ),
          CustomComboDialog(
            fonteDados: _controller.carregaBancos,
            chave: 'nome;numero',
            lista: _controller.bancos,
            titulo: 'Bancos',
            onTap: _controller.selecionaBanco,
            valorAtual: _controller.state?.banco?.nome ?? '',
            addNovo: () async => await Get.toNamed('/bancos'),
            label: 'banco',
          ),
        ],
      ),
    );
  }
}
