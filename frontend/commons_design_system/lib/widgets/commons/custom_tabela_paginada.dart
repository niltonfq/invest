import 'package:flutter/material.dart';

class CustomTabelaPaginada<T> extends StatelessWidget {
  final List<String> colunas;
  final List<T> dados;
  final List<String Function(T)> gerarDadosColunas;
  final int registrosPorPagina;
  final int totalDeRegistros;
  final int pagina;
  final Function(int) onChangedPage;

  CustomTabelaPaginada({
    required this.colunas,
    required this.dados,
    required this.gerarDadosColunas,
    required this.registrosPorPagina,
    required this.onChangedPage,
    required this.totalDeRegistros, required this.pagina,
  });

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      columns: colunas
          .map(
            (coluna) => DataColumn(label: Text(coluna)),
          )
          .toList(),
      source: _DataSource<T>(dados, gerarDadosColunas, totalDeRegistros, pagina, registrosPorPagina),
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
  int _pagina = 0;
  int _registrosPorPagina = 0;

  _DataSource(this._dados, this.gerarDadosColunas, this._totalDeRegistros, this._pagina,
  this._registrosPorPagina);

  @override
  DataRow getRow(int index) {
    index = _pagina
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
