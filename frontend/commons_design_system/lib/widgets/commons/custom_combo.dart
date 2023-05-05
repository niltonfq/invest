import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';

class CustomCombo extends StatelessWidget {
  final String titulo;
  final String chave;
  final RxList<dynamic> lista;
  final Future<void> Function(int, String) buscaDados;
  final _works = <Worker>[];
  final RxString _busca = ''.obs;
  final _buscaTec = TextEditingController();
  final void Function(Map<String, dynamic>) onTap;
  final String valorAtual;

  CustomCombo({
    Key? key,
    required this.chave,
    required this.titulo,
    required this.lista,
    required this.buscaDados,
    required this.onTap,
    required this.valorAtual,
  }) : super(key: key) {
    _buscaTec.text = valorAtual;
  }

  final ScrollController _controller = ScrollController();

  final _pagina = 0.obs;

  init(Future<void> Function(int paginaAtivo, String busca) buscaDados) {
    final workerDebounce = debounce<String>(_busca, (busca) {
      _pagina(0);
      buscaDados(_pagina.value, _busca.value);
    });

    _works.add(workerDebounce);
    final _workerPagina = ever<int>(_pagina, (_) {
      if (_pagina.value > 0) {
        buscaDados(_pagina.value, _busca.value);
      }
    });
    _works.add(_workerPagina);

    _controller.addListener(
      () {
        if (_controller.offset >= _controller.position.maxScrollExtent &&
            !_controller.position.outOfRange) {
          _pagina.value++;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      label: 'Ativos',
      controller: _buscaTec,
      readOnly: true,
      suffixIcon: CustomIconButton(
        icon: Icon(Icons.expand_more_rounded, color: Colors.white),
        onPressed: () async {
          await show(
            context: context,
            titulo: titulo,
            lista: lista,
            chave: chave,
            buscaDados: buscaDados,
          );
        },
      ),
    );
  }

  Future show({
    required BuildContext context,
    required String titulo,
    required RxList<dynamic> lista,
    required String chave,
    required Future<void> Function(int paginaAtivo, String busca) buscaDados,
  }) async {
    init(buscaDados);

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: Row(
          children: [
            Text(
              titulo,
            ),
            Spacer(),
            CustomIconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            )
          ],
        ),
        children: [
          CustomTextFormField(
            label: 'Pesquisar',
            onChanged: (value) {
              _busca(value);
            },
          ),
          Obx(
            () => SizedBox(
              height: 100,
              width: 500,
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                controller: _controller,
                itemCount: lista.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child:
                        SizedBox(height: 30, child: Text(lista[index][chave])),
                    onTap: () {
                      onTap(lista[index]);
                      _buscaTec.text = lista[index][chave];
                      voltar();
                    },
                  );
                },
              ),
            ),
          ),
          CustomButton(
            child: Text('Fechar'),
            onPressed: () {
              voltar();
            },
          )
        ],
      ),
    );
  }

  void voltar() {
    for (var element in _works) {
      element.dispose();
    }
    Get.back();
  }
}
