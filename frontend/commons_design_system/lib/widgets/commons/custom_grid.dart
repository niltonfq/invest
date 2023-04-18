import 'package:flutter/material.dart';

class DTS extends DataTableSource {
  @override
  DataRow getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text('#cel1$index')),
        DataCell(Text('#cel2$index')),
        DataCell(Text('#cel3$index')),
        DataCell(Text('#cel4$index')),
        DataCell(Text('#cel5$index')),
        DataCell(Text('#cel6$index')),
      ],
    );
  }
  
  @override
  bool get isRowCountApproximate => false;
  
  @override
  int get rowCount => 100;
  
  @override
  int get selectedRowCount => 0;
}

class CustomGrid extends StatefulWidget {
  @override
  _CustomGridState createState() => _CustomGridState();
}

class _CustomGridState extends State<CustomGrid> {
  List<bool> selected = List<bool>.generate(100, (index) => false);
  var dts = DTS();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: 600.0,
        child: SingleChildScrollView(
          child: PaginatedDataTable(
            header: Text('Paginated Data Table'),
            sortAscending: true,
            showCheckboxColumn: true,
            columns: [
              DataColumn(label: Text('Col 1')),
              DataColumn(label: Text('Col 2')),
              DataColumn(label: Text('Col 3')),
              DataColumn(label: Text('Col 4')),
              DataColumn(label: Text('Col 5')),
              DataColumn(label: Text('Col 6')),
            ],
            source: dts,
          ),
        ),
      ),
    );
  }
}
