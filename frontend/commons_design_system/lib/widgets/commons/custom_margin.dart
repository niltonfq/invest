import 'package:flutter/material.dart';

class CustomMargin extends StatelessWidget {
  final Widget child;
  final double top;
  final double bottom;
  final double left;
  final double right;
  final double? all;

  const CustomMargin(
      {Key? key,
      required this.child,
      this.top = 0,
      this.bottom = 0,
      this.left = 0,
      this.right = 0,
      this.all})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: all != null
          ? EdgeInsets.all(all!)
          : EdgeInsets.only(top: top, bottom: bottom, left: left, right: right),
      child: child,
    );
  }
}
