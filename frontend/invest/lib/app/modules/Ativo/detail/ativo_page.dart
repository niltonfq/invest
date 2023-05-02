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
          CustomCombo(
            titulo: 'Banco',
            onItemTap: (value) {},
            controller: _controller.bancoTEC,
            lista: _controller.bancoList,
            onPressedButton: () async {
              await Get.toNamed("/banco");
            },
          )
        ],
      ),
    );
  }
}
