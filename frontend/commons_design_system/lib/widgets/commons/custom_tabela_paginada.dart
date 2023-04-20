import 'package:flutter/material.dart';

import '../../commons_design_system.dart';

class CustomTabelaPaginada extends StatelessWidget {
  final List<DataColumn> columns;
  final List<DataRow> rows;
  final int? sortColumnIndex;
  final bool sortAscending;
  final void Function()? primeira;
  final void Function()? anterior;
  final void Function()? proxima;
  final void Function()? ultima;
  final int pagina;
  final int totalPaginas;

  const CustomTabelaPaginada({
    Key? key,
    required this.columns,
    required this.rows,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.primeira,
    this.anterior,
    this.proxima,
    this.ultima,
    required this.pagina,
    required this.totalPaginas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DataTable(
          columns: columns,
          rows: rows,
          sortColumnIndex: sortColumnIndex,
          sortAscending: sortAscending,
        ),
        Wrap(
          spacing: 20,
          children: [
            SizedBox(
              width: 100,
              child: Text('${pagina + 1} / ${totalPaginas + 1}  '),
            ),
            SizedBox(
              width: 100,
              child: CustomButton(
                child: Text("Primeira"),
                onPressed: primeira,
              ),
            ),
            SizedBox(
              width: 100,
              child: CustomButton(
                child: Text("Anterior"),
                onPressed: anterior,
              ),
            ),
            SizedBox(
              width: 100,
              child: CustomButton(
                child: Text("Próxima"),
                onPressed: proxima,
              ),
            ),
            SizedBox(
              width: 100,
              child: CustomButton(
                child: Text("Última"),
                onPressed: ultima,
              ),
            ),
          ],
        ),
        Spacer()
      ],
    );
  }
}
