import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../commons_design_system.dart';

class CustomTextFormField extends StatefulWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String label;
  final bool isSecret;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final bool readOnly;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final GlobalKey<FormFieldState>? formFieldKey;
  final double borderRadius;
  final void Function(String)? onChanged;

  const CustomTextFormField({
    Key? key,
    required this.label,
    this.isSecret = false,
    this.inputFormatters,
    this.initialValue,
    this.readOnly = false,
    this.validator,
    this.onSaved,
    this.controller,
    this.textInputType,
    this.formFieldKey,
    this.borderRadius = 0,
    this.prefixIcon,
    this.suffixIcon, this.onChanged,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool isObscure = false;
  FocusNode myFocusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      key: widget.formFieldKey,
      controller: widget.controller,
      readOnly: widget.readOnly,
      initialValue: widget.initialValue,
      inputFormatters: widget.inputFormatters,
      obscureText: isObscure,
      validator: widget.validator,
      onSaved: widget.onSaved,
      keyboardType: widget.textInputType,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        isDense: true,
        
        contentPadding:
            const EdgeInsets.symmetric(vertical: 12.0, horizontal: 17.0),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isSecret
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                icon: Icon(
                  isObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: CustomColors.destaque,
                ),
              )
            : widget.suffixIcon,
        labelText: widget.label,
        labelStyle: TextStyle(
          fontFamily: 'OpenSans',
          color: myFocusNode.hasFocus
              ? CustomColors.branco
              : CustomColors.branco.withAlpha(100),
          fontWeight: FontWeight.w200,
          fontSize: 16,
        ),
        filled: true,
        fillColor: CustomColors.fundo_tela,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            color: CustomColors.destaque,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: BorderSide(
            color: CustomColors.branco,
            width: 1.0,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    isObscure = widget.isSecret;
    super.initState();
  }
}
