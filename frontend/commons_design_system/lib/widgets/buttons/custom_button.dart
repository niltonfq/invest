// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final Widget child;
  final double padding;
  final double height;
  final double? width;
  final double top;
  final ButtonStyle? style;

  const CustomButton({
    Key? key,
    this.onPressed,
    required this.child,
    this.padding = 8,
    this.height = 40,
    this.width = double.infinity,
    this.top = 8,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: top),
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: style,
        
      ),
    );
  }
}
