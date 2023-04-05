import 'package:flutter/material.dart';

import 'ativo_posicao_controller.dart';

class AtivoPosicaoPage extends StatelessWidget {
  final AtivoPosicaoController _controller;

  const AtivoPosicaoPage({required AtivoPosicaoController controller})
      : _controller = controller,
        super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Placeholder(),
    );
  }
}
