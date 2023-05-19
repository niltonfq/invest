import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validatorless/validatorless.dart';

class AbsTextFormField extends StatefulWidget {
  const AbsTextFormField({
    Key? key,
    this.enabled = true,
    required this.titulo,
    this.initialValue,
    this.validator,
    this.autovalidateMode,
    this.placeholder,
    this.padding = 8,
    this.controller,
    this.required = false,
    this.onChanged,
    this.inputFormatters,
    this.onFieldSubmitted,
    this.textAlign = TextAlign.start,
    this.keyboardType,
    this.obscureText = false,
  }) : super(key: key);
  final bool enabled;
  final String titulo;
  final String? placeholder;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;
  final double padding;
  final TextEditingController? controller;
  final bool required;
  final void Function(String)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign textAlign;
  final void Function(String)? onFieldSubmitted;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  State<AbsTextFormField> createState() => _AbsTextFormFieldState();
}

class _AbsTextFormFieldState extends State<AbsTextFormField> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.titulo.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  Text(
                    widget.titulo,
                    style: widget.enabled
                        ? Theme.of(context).textTheme.bodyLarge
                        : Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context)
                                  .inputDecorationTheme
                                  .hintStyle
                                  ?.color,
                            ),
                  ),
                  widget.required
                      ? Text(
                          ' *',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Theme.of(context)
                                        .inputDecorationTheme
                                        .errorStyle
                                        ?.color,
                                  ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          TextFormField(
            controller: widget.controller,
            validator: (widget.required && (widget.validator == null))
                ? Validatorless.required('Campo obrigatório')
                : widget.validator,
            focusNode: focusNode,
            initialValue: widget.initialValue,
            autovalidateMode: widget.autovalidateMode,
            enabled: widget.enabled,
            onChanged: widget.onChanged,
            obscureText: widget.obscureText,
            onFieldSubmitted: widget.onFieldSubmitted,
            keyboardType: widget.keyboardType,
            style: !widget.enabled
                ? TextStyle(
                    color: Theme.of(context).disabledColor,
                  )
                : null,
            textAlign: widget.textAlign,
            decoration: InputDecoration(
              fillColor: !widget.enabled
                  ? Theme.of(context).scaffoldBackgroundColor
                  : null,
              hintText: widget.placeholder,
            ),
          ),
        ],
      ),
    );
  }
}
