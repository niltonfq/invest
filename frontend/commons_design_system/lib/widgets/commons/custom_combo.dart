import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';

class CustomCombo extends StatefulWidget {
  final String titulo;
  final String chave;
  final List<dynamic> lista;
  final Future<void> Function(int) buscaDados;
  const CustomCombo({
    Key? key,
    required this.chave,
    required this.titulo,
    required this.lista,
    required this.buscaDados,
  }) : super(key: key);

  @override
  State<CustomCombo> createState() => _CustomComboState();
}

class _CustomComboState extends State<CustomCombo> {
  ScrollController _controller = ScrollController();
  int pagina = 0;

  init(Future<void> Function(int paginaAtivo) buscaDados) {
    _controller.addListener(() {
      if (_controller.offset >= _controller.position.maxScrollExtent &&
          !_controller.position.outOfRange) {
        pagina++;
        setState(() {
          buscaDados(pagina);
          print(pagina);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      label: 'Ativos',
      suffixIcon: CustomIconButton(
        icon: Icon(Icons.abc, color: Colors.white),
        onPressed: () async {
          await show(
            context: context,
            titulo: widget.titulo,
            lista: widget.lista,
            chave: widget.chave,
            buscaDados: widget.buscaDados,
          );
        },
      ),
    );
  }

  Future show({
    required BuildContext context,
    required String titulo,
    required List<dynamic> lista,
    required String chave,
    required Future<void> Function(int paginaAtivo) buscaDados,
  }) async {
    init(buscaDados);

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: Text(titulo),
        children: [
          CustomTextFormField(label: 'Pesquisar'),
          SizedBox(
            height: 100,
            width: 500,
            child: ListView.builder(
              controller: _controller,
              itemCount: lista.length,
              itemBuilder: (context, index) {
                return Text(lista[index][chave]);
              },
            ),
          )
        ],
      ),
    );
  }
}
