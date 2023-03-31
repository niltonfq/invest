import 'package:flutter/material.dart';

import '../../custom_colors.dart';

class CustomAppName extends StatelessWidget {
  final double textSize;
  final String prefixo;
  final String sufixo;

  const CustomAppName({
    Key? key,
    this.textSize = 30,
    required this.prefixo,
    required this.sufixo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: textSize,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: prefixo,
            style: TextStyle(
              color: CustomColors.destaque,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: sufixo,
            style: TextStyle(
              color: CustomColors.branco,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
