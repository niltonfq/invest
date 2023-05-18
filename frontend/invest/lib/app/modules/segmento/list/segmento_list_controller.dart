import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';

import '../segmento_model.dart';
import '../segmento_service.dart';

class SegmentoListController extends GetxController
    with StateMixin<List<SegmentoModel>> {
  final SegmentoService _segmentoService;

  String ordem = 'nome,ASC';

  final _isLoading = false.obs;

  bool sortAscending = true;
  get isLoading => _isLoading.value;

  final _totalItens = 0.obs;
  get totalItens => _totalItens.value;

  final int _totalPorPagina = 10;
  get totalPorPagina => _totalPorPagina;

  get ultimaPagina => (totalItens / totalPorPagina).ceil() - 1;

  final _pagina = 0.obs;
  get pagina => _pagina.value;
  setPagina(value) async {
    _isLoading(true);
    if (value < 0) value = 0;
    if (value > (totalItens / totalPorPagina)) {
      value = (totalItens / totalPorPagina);
    }
    _pagina(value);
    await findAll();
    _isLoading(false);
  }

  SegmentoListController({
    required SegmentoService segmentoService,
  })  : _segmentoService = segmentoService,
        super();

  @override
  void onReady() async {
    await findAll();
    super.onReady();
  }

  Future<void> findAll() async {
    _isLoading(true);
    final result = await _segmentoService.findAll(page: pagina, sort: ordem);
    await result.fold(
      (success) async {
        List content = (success.body['content'] as List);
        var list = SegmentoModel.fromJsonList(content);
        int totalRegistros =
            int.tryParse(success.body['totalElements'].toString()) ?? 0;
        _totalItens(totalRegistros);
        change(list, status: RxStatus.success());
        _isLoading(false);
      },
      ((failure) {
        _isLoading(false);
        CustomSnackbar.erro(mensagem: failure.toString());
      }),
    );
  }

  Future<void> trocaPagina(int value) async {
    setPagina(value / totalPorPagina.ceil());

    await findAll();
  }

  List<DataRow> linhas() {
    return state!
        .map(
          (e) => DataRow(
            cells: [
              DataCell(
                InkWell(
                  child: Text(
                    e.nome ?? "",
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: CustomColors.Link,
                    ),
                  ),
                  onTap: () =>
                      Get.toNamed("/segmento", arguments: {"id": e.id}),
                ),
              ),
              DataCell(
                CustomButton(
                  child: const Text('Deletar'),
                  onPressed: () {
                    _segmentoService.deleteApi(e.id!);
                    state?.remove(e);
                    change(state, status: RxStatus.success());
                    CustomSnackbar.sucesso('Excluido com sucesso');
                    if (state!.isEmpty) {
                      setPagina(0);
                    }
                  },
                ),
              ),
            ],
          ),
        )
        .toList();
  }

  sort(String nome) {
    sortAscending = !sortAscending;
    if (sortAscending) {
      ordem = nome + ',ASC';
    } else {
      ordem = nome + ',DESC';
    }
    setPagina(0);
  }
}
