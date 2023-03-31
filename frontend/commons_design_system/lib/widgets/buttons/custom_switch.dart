import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  const CustomSwitch({
    Key? key,
    required this.value,
    this.onChanged,
    this.title,
    this.padding = 8,
  }) : super(key: key);

  final bool value;
  final void Function(bool)? onChanged;
  final Widget? title;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        title: title,
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
