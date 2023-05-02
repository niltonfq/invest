import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'banco_list_controller.dart';

class BancoListPage extends GetView<BancoListController> {
  const BancoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Corretora / Banco'),
        ),
        floatingActionButton: FloatingActionButton(
          mini: true,
          onPressed: () async {
            Get.toNamed("/bancoPage");
          },
          child: const Icon(Icons.add),
        ),
        body: Container());
  }
}
