import 'package:flutter/material.dart';

class AbsIcon extends StatelessWidget {
  const AbsIcon({Key? key, required this.nome}) : super(key: key);

  final String nome;

  @override
  Widget build(BuildContext context) {
    Brightness tema = Theme.of(context).brightness;
    String file = tema.name == 'dark' ? '${nome}_dark.png' : '$nome.png';
    return ImageIcon(
      AssetImage(file),
    );
  }
}
