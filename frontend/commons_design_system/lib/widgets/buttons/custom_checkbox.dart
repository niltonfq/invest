import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox(
      {Key? key,
      required this.value,
      this.onChanged,
      required this.child,
      this.padding = 8})
      : super(key: key);

  final bool value;
  final void Function(bool?)? onChanged;
  final Widget child;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Checkbox(
              value: value,
              onChanged: (bool? value) {
                if (onChanged != null) {
                    onChanged!(value);
                }
              }),
          child
        ],
      ),
    );
  }
}
