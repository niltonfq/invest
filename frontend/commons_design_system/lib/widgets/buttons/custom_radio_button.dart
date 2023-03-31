import 'package:flutter/material.dart';

class CustomRadioButton<T> extends StatelessWidget {
  const CustomRadioButton({
    Key? key,
    this.onChanged,
    required this.child,
    this.groupValue,
    required this.value,
    this.padding = 8,
  }) : super(key: key);

  final void Function(T?)? onChanged;
  final Widget child;
  final T? groupValue;
  final T value;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Radio<T>(
            groupValue: groupValue,
            onChanged: onChanged,
            value: value,
          ),
          child,
        ],
      ),
    );
  }
}
