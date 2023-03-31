import 'package:flutter/material.dart';

class AbsSearch extends StatefulWidget {
  const AbsSearch({
    Key? key,
    this.enabled = true,
    this.initialValue,
    this.validator,
    required this.titulo,
    this.autovalidateMode,
    this.placeholder,
    this.onPressed,
    required this.child,
    this.padding = 8,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  final bool enabled;
  final String? placeholder;
  final String titulo;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final void Function()? onPressed;
  final Widget child;
  final double padding;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  @override
  State<AbsSearch> createState() => _AbsSearchState();
}

class _AbsSearchState extends State<AbsSearch> {
  FocusNode focusNode = FocusNode();
  String hintText = '';
  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = '';
      } else {
        hintText = '';
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(widget.padding),
      child: LayoutBuilder(builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                widget.titulo,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: widget.controller,
                    validator: widget.validator,
                    focusNode: focusNode,
                    initialValue: widget.initialValue,
                    autovalidateMode: widget.autovalidateMode,
                    enabled: widget.enabled,
                    onChanged: widget.onChanged,
                    onFieldSubmitted: ((value) {
                      if (widget.onPressed != null) {
                        widget.onPressed!();
                      }
                    }),
                    style: !widget.enabled
                        ? TextStyle(color: Theme.of(context).disabledColor)
                        : null,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          onPressed: widget.onPressed,
                          icon: const Icon(
                            Icons.search,
                          )),
                      hintText: widget.placeholder,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
