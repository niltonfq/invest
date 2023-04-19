import 'package:flutter/material.dart';

class CustomTabelaPaginada<T> extends StatelessWidget {
  final List<String> colunas;
  final List<T> dados;
  final List<String Function(T)> gerarDadosColunas;
  final int registrosPorPagina;
  final int totalDeRegistros;
  final Function(int) onChangedPage;

  CustomTabelaPaginada({
    required this.colunas,
    required this.dados,
    required this.gerarDadosColunas,
    required this.registrosPorPagina,
    required this.onChangedPage,
    required this.totalDeRegistros,
  });

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      columns: colunas
          .map(
            (coluna) => DataColumn(label: Text(coluna)),
          )
          .toList(),
      source: _DataSource<T>(dados, gerarDadosColunas, totalDeRegistros),
      rowsPerPage: registrosPorPagina,
      onPageChanged: onChangedPage,
    );
  }
}

class _DataSource<T> extends DataTableSource {
  List<T> _dados;
  int _selectedRowCount = 0;
  final List<String Function(T)> gerarDadosColunas;
  int _totalDeRegistros = 0;

  _DataSource(this._dados, this.gerarDadosColunas, this._totalDeRegistros);

  @override
  DataRow getRow(int index) {
    final dado = _dados[index];
    final cells = gerarDadosColunas
        .map(
          (gerarDadoColuna) => DataCell(Text(gerarDadoColuna(dado))),
        )
        .toList();
    return DataRow.byIndex(
      index: index,
      cells: cells,
    );
  }

  @override
  int get rowCount => _totalDeRegistros;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedRowCount;

  void sort<T>(Comparable<T> Function(T d) getField, bool ascending) {}
}
