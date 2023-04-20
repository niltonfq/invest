import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';

import '../ativo_service.dart';
import '../models/ativo_model.dart';

class AtivoListController extends GetxController
    with StateMixin<List<AtivoModel>> {
  final AtivoService _ativoService;

  final _isLoading = false.obs;
  get isLoading => _isLoading.value;

  final _totalItens = 0.obs;
  get totalItens => _totalItens.value;

  final int _totalPorPagina = 10;
  get totalPorPagina => _totalPorPagina;

  get ultimaPagina => (totalItens / totalPorPagina).ceil() - 1;

  final _pagina = 0.obs;
  get pagina => _pagina.value;
  setPagina(value) {
    
    if (value < 0) value = 0;
    if (value > (totalItens / totalPorPagina)) value = (totalItens / totalPorPagina);
    _pagina(value);
    findAll();
  }

  AtivoListController({
    required AtivoService ativoService,
  })  : _ativoService = ativoService,
        super();

  @override
  void onReady() async {
    await findAll();
    super.onReady();
  }

  Future<void> findAll() async {
    _isLoading(true);
    final result = await _ativoService.findAll(pagina);
    await result.fold(
      (success) async {
        List content = (success.body['content'] as List);
        var list = AtivoModel.fromJsonList(content);
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
              DataCell(Text(e.codigo ?? "")),
              DataCell(Text(e.nome ?? "")),
            ],
          ),
        )
        .toList();
  }
}
