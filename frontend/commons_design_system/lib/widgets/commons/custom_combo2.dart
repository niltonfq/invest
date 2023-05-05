import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';

class CustomCombo2 {
  static ScrollController _controller = ScrollController();
  static int pagina = 0;

  static init(void Function(int paginaAtivo) buscaDados) {
    _controller.addListener(() {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        pagina++;
      }
    });
  }

  static Future show({
    required BuildContext context,
    required String title,
    required List<dynamic> list,
    required String chave,
    required void Function(int paginaAtivo) buscaDados,
  }) async {
    init(buscaDados);

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: Text(title),
        children: [
          CustomTextFormField(label: 'Pesquisar'),
          SizedBox(
            height: 100,
            width: 500,
            child: ListView.builder(
              controller: _controller,
              itemCount: list.length,
              itemBuilder: (context, index) {
                return Text(list[index][chave]);
              },
            ),
          )
        ],
      ),
    );
  }
}
