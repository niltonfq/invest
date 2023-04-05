import 'package:commons_deps/commons_deps.dart';
import 'package:commons_design_system/commons_design_system.dart';
import 'package:flutter/material.dart';

import '../../tipo_ativo/models/tipo_ativo_view_model.dart';
import '../models/ativo_view_model.dart';
import 'ativo_posicao_controller.dart';

class AtivoPosicaoPage extends StatelessWidget {
  final AtivoPosicaoController _controller;

  const AtivoPosicaoPage({Key? key, required AtivoPosicaoController controller})
      : _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Posição ativos por tipo',
      home: Scaffold(
          appBar: AppBar(title: const Text('Posição ativos por tipo')),
          body: _controller.obx(
            (state) {
              return ExpandingItems(lista: state ?? []);
            },
          )),
    );
  }
}

class ExpandingItems extends StatefulWidget {
  final List<TipoAtivoViewModel> lista;
  const ExpandingItems({required this.lista, Key? key}) : super(key: key);

  @override
  _ExpandingItemsState createState() => _ExpandingItemsState();
}

class _ExpandingItemsState extends State<ExpandingItems> {
  late List<bool> _isExpanded;

  @override
  void initState() {
    _isExpanded = List.generate(widget.lista.length, (_) => false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (index, isExpanded) => setState(() {
          _isExpanded[index] = !isExpanded;
        }),
        children: [
          for (int i = 0; i < widget.lista.length; i++)
            ExpansionPanel(
              body: ListTile(subtitle: grid(widget.lista[i], context)),
              headerBuilder: (_, isExpanded) {
                return Row(
                  children: [
                    const Spacer(),
                    Text(widget.lista[i].tipoAtivo ?? ""),
                    const Spacer(),
                    Text(" ${widget.lista[i].quantidade}  Ativo(s)"),
                    const Spacer(),
                    Text(widget.lista[i].percentualFormatado),
                    const Spacer(),
                    Text(widget.lista[i].totalFormatado),
                  ],
                );
              },
              isExpanded: _isExpanded[i],
            )
        ],
      ),
    );
  }

  Widget grid(TipoAtivoViewModel tipoAtivoViewModel, BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        child: DataTable(
          columnSpacing: 10,
          headingRowColor: MaterialStateProperty.all(CustomColors.branco),
          columns: [
            const DataColumn(label: Text('Ativo')),
            const DataColumn(
                label: Text('Preço médio', overflow: TextOverflow.ellipsis)),
            const DataColumn(
                label: Text(
              'Preço atual',
              overflow: TextOverflow.ellipsis,
            )),
            const DataColumn(label: Text('Diferença')),
            const DataColumn(label: Text('% Diferença')),
            const DataColumn(label: Text('Quantidade')),
            const DataColumn(
                label: Text(
              'Total investido',
              overflow: TextOverflow.ellipsis,
            )),
            const DataColumn(
                label: Text(
              'Patrimônio atual',
              overflow: TextOverflow.ellipsis,
            )),
            DataColumn(label: Text('% ${tipoAtivoViewModel.tipoAtivo}')),
            const DataColumn(label: Text('% Carteira')),
          ],
          rows: List.generate(
            tipoAtivoViewModel.ativos?.length ?? 0,
            (index) {
              AtivoViewModel model = tipoAtivoViewModel.ativos![index];
              return DataRow(
                cells: [
                  DataCell(Text(model.codigo ?? '')),
                  DataCell(Text(model.precoMedioFormatado)),
                  DataCell(Text(model.precoAtualFormatado)),
                  DataCell(Text(model.diferencaFormatada)),
                  DataCell(Text(model.percentualDiferencaFormatada)),
                  DataCell(Text(model.quantidade.toString())),
                  DataCell(Text(model.totalInvestidoFormatado)),
                  DataCell(Text(model.patrimonioFormatado)),
                  DataCell(Text(model.percentualFormatado)),
                  DataCell(Text(model.percentualCarteiraFormatado)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
