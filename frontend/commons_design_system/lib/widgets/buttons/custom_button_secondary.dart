// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../custom_colors.dart';

class CustomButtonSecondary extends StatelessWidget {
  final void Function()? onPressed;

  final Widget child;
  final double padding;
  final double height;
  final double? width;
  const CustomButtonSecondary({
    Key? key,
    this.onPressed,
    required this.child,
    this.padding = 8,
    this.height = 46,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: onPressed,
        child: child,
        style: OutlinedButton.styleFrom(
          backgroundColor: CustomColors.fundo_tela,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(45),
          ),
          side: BorderSide(width: 1, color: CustomColors.destaque),
        ),
      ),
    );
  }
}
