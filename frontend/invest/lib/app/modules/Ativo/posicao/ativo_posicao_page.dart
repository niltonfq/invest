import 'package:flutter/material.dart';

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
        body: const ExpandingItems(),
      ),
    );
  }
}

class ExpandingItems extends StatefulWidget {
  const ExpandingItems({Key? key}) : super(key: key);

  @override
  _ExpandingItemsState createState() => _ExpandingItemsState();
}

class _ExpandingItemsState extends State<ExpandingItems> {
  final List<bool> _isExpanded = List.generate(10, (_) => false);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: (index, isExpanded) => setState(() {
          _isExpanded[index] = !isExpanded;
        }),
        children: [
          for (int i = 0; i < 10; i++)
            ExpansionPanel(
              body: const ListTile(
                  subtitle: Text(
                      "... amet, consectetur adipiscing elit. Nullam ultricies porta rutrum. Vivamus id ultrices velit. Sed tellus lorem, egestas ac magna non, fringilla sagittis erat. Interdum et malesuada fames ac ante ipsum primis in faucibus. Fusce tempor mi et eleifend fermentum. Sed quis molestie nunc.")),
              headerBuilder: (_, isExpanded) {
                return const Center(
                  child: Text("Lorem ipsum dolor sit ..."),
                );
              },
              isExpanded: _isExpanded[i],
            )
        ],
      ),
    );
  }
}
