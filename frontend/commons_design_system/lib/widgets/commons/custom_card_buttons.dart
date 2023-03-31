import 'package:flutter/material.dart';

class CustomCardButtons extends StatelessWidget {
  final int flex;

  final double padding;
  final List<Widget> linhas;
  final List<Widget> botoes;
  final List<Widget> title;
  final double width;
  const CustomCardButtons({
    Key? key,
    this.flex = 1,
    this.padding = 0,
    this.linhas = const <Widget>[],
    this.botoes = const <Widget>[],
    required this.title,
    this.width = 500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: title,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: linhas,
                ),
                const Spacer(),
                Row(
                  children: botoes,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
