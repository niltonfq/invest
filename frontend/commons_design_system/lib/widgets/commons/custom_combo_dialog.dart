import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';

class CustomComboDialog extends StatelessWidget {
  final String titulo;
  final String chave;
  final RxList<dynamic> lista;
  final Future<void> Function(int, String) fonteDados;
  final _works = <Worker>[];
  final RxString _busca = ''.obs;
  final _buscaTec = TextEditingController();
  final void Function(Map<String, dynamic>) onTap;
  final String? valorAtual;
  final Future<void> Function()? addNovo;
  final _isLoading = false.obs;
  List<String> campos = [];
  final ScrollController _controller = ScrollController();
  final _pagina = 0.obs;
  final String label;

  CustomComboDialog({
    Key? key,
    required this.chave,
    required this.titulo,
    required this.lista,
    required this.fonteDados,
    required this.onTap,
    required this.valorAtual,
    this.addNovo,
    required this.label,
  }) : super(key: key) {
    _buscaTec.text = valorAtual ?? '';
  }

  _carregaDados() {
    _isLoading(true);
    fonteDados(_pagina.value, _busca.value);
    _isLoading(false);
  }

  init(Future<void> Function(int paginaAtivo, String busca) fonteDados) {
    campos = chave.split(';');
    _carregaDados();

    final workerDebounce = debounce<String>(_busca, (busca) {
      _pagina(0);
      _carregaDados();
    });

    _works.add(workerDebounce);
    final _workerPagina = ever<int>(_pagina, (_) async {
      if (_pagina.value > 0) {
        await _carregaDados();
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
      label: label,
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
            fonteDados: fonteDados,
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
    required Future<void> Function(int paginaAtivo, String busca) fonteDados,
  }) async {
    init(fonteDados);

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
              icon: Icon(Icons.close),
              onPressed: () {
                Get.back();
              },
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
              height: 300,
              width: Get.width * .70,
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(8),
                controller: _controller,
                itemCount: lista.length + (_isLoading.value ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == lista.length) {
                    return Center(child: CircularProgressIndicator());
                  }

                  return InkWell(
                    child: SizedBox(
                        height: 30, child: Row(children: resolveCampos(index))),
                    onTap: () {
                      onTap(lista[index]);
                      _buscaTec.text = lista[index][campos[0]];
                      Get.back();
                    },
                  );
                },
              ),
            ),
          ),
          Visibility(
            visible: addNovo != null,
            child: CustomButton(
                child: Text('Novo'),
                onPressed: () async {
                  if (addNovo != null) {
                    await addNovo!();
                  }
                  _pagina(0);
                }),
          )
        ],
      ),
    ).then((value) => voltar());
  }

  void voltar() {
    for (var element in _works) {
      element.dispose();
    }
  }

  List<Widget> resolveCampos(index) {
    List<Widget> listaWidget = [];
    for (var campo in campos) {
      listaWidget.add(Expanded(child: Text(lista[index][campo] ?? '')));
    }

    return listaWidget;
  }
}
