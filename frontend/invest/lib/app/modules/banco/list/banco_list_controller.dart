import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';

import '../banco_model.dart';
import '../banco_service.dart';

class BancoListController extends GetxController
    with StateMixin<List<BancoModel>> {
  final BancoService _bancoService;

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
    if (value > (totalItens / totalPorPagina)) {
      value = (totalItens / totalPorPagina);
    }
    _pagina(value);
    findAll();
  }

  BancoListController({
    required BancoService bancoService,
  })  : _bancoService = bancoService,
        super();

  @override
  void onReady() async {
    await findAll();
    super.onReady();
  }

  Future<void> findAll() async {
    _isLoading(true);
    final result = await _bancoService.findAll(pagina);
    await result.fold(
      (success) async {
        List content = (success.body['content'] as List);
        var list = BancoModel.fromJsonList(content);
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
              DataCell(CustomButton(
                child: Text(e.nome ?? ""),
                onPressed: () => Get.toNamed("/bancoPage", arguments: e.id),
              )),
              DataCell(Text(e.cnpj ?? "")),
            ],
          ),
        )
        .toList();
  }
}
