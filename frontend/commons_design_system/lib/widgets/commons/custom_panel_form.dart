import 'package:flutter/material.dart';

import '../../custom_colors.dart';

class CustomPanelForm extends StatelessWidget {
  final Widget? child;
  final double? height;
  final double? width;

  CustomPanelForm({Key? key, this.child, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      constraints: const BoxConstraints(maxWidth: 604),
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 35),
      decoration: const BoxDecoration(
        color: CustomColors.fundo_widgets,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(45),
        ),
      ),
      child: child,
    );
  }
}
