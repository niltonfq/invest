import 'package:flutter/material.dart';

class AbsTabBar extends StatelessWidget {
  const AbsTabBar({Key? key, required this.body}) : super(key: key);

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Aba 1 (Selecionada)'),
            Text('Aba 2'),
            Text('Aba 3'),
            Text('Aba 4'),
            Text('Aba 5'),
          ],
        ),
        body
      ],
    );
  }
}
