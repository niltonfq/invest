import 'package:commons_deps/commons_deps.dart';
import 'package:flutter/material.dart';

class CustomCombo<T> extends StatefulWidget {
  final String titulo;

  final FormFieldValidator<String>? validator;
  final bool enabled;
  final String? placeholder;
  final List<T> lista;
  final TextEditingController controller;
  final void Function()? onPressedButton;
  final Future<void> Function()? onScroll;
  final void Function(dynamic) onItemTap;
  final Future<void> Function(String)? onChanged;
  final bool required;
  const CustomCombo({
    Key? key,
    required this.titulo,
    required this.onItemTap,
    required this.controller,
    required this.lista,
    this.onScroll,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.placeholder,
    this.onPressedButton,
    this.required = false,
  }) : super(key: key);

  @override
  CustomComboState createState() => CustomComboState();
}

class CustomComboState<T> extends State<CustomCombo> {
  final FocusNode _focusNode = FocusNode();

  OverlayEntry? _overlayEntry;

  final LayerLink _layerLink = LayerLink();

  final ValueNotifier<bool> _show = ValueNotifier(false);
  final ValueNotifier<bool> _update = ValueNotifier(false);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            widget.required
                ? Text(
                    ' *',
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Theme.of(context)
                              .inputDecorationTheme
                              .errorStyle
                              ?.color,
                        ),
                  )
                : Container(),
          ],
        ),
        CompositedTransformTarget(
          link: _layerLink,
          child: TextFormField(
            validator: (widget.required && (widget.validator == null))
                ? Validatorless.required('Campo obrigatório')
                : widget.validator,
            focusNode: _focusNode,
            controller: widget.controller,
            onChanged: (value) {
              setState(() async {
                if (widget.onChanged != null) {
                  await widget.onChanged!(value);
                  _update.value = !_update.value;
                }
                _show.value = true;
              });
            },
            enabled: widget.enabled,
            decoration: InputDecoration(
              isDense: true,
              suffixIcon: IconButton(
                padding: const EdgeInsets.only(right: 16),
                icon: _show.value
                    ? const Icon(Icons.arrow_drop_up)
                    : const Icon(Icons.arrow_drop_down),
                onPressed: () {
                  setState(() {
                    _show.value = !_show.value;
                  });
                },
              ),
              labelText: widget.titulo,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _show.value = true;
      } else {
        _show.value = false;
      }
    });

    _show.addListener(() {
      if (_show.value) {
        _overlayEntry = _createOverlayEntry();
        Overlay.of(context).insert(_overlayEntry!);
      } else {
        if (_overlayEntry != null) {
          _overlayEntry?.remove();
        }
      }
    });

    _scrollController.addListener(() async {
      if (widget.onScroll != null) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          await widget.onScroll!();
          _update.value = !_update.value;
        }
      }
    });

    super.initState();
  }

  List<Widget> montaCombo() {
    if (widget.lista.isEmpty) {
      return [];
    }
    return widget.lista
        .map(
          (item) => ListTile(
            title: Text(
              item.toString(),
            ),
            onTap: () {
              setState(() {
                widget.controller.text = item.toString();
                _show.value = false;
                widget.onItemTap(item);
              });
            },
          ),
        )
        .toList();
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;
    double largura = size.width - 14;

    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: largura,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: const Offset(0, 53),
            child: Material(
              elevation: 4.0,
              child: Column(
                children: [
                  Container(
                    height: 200,
                    width: largura,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).dividerColor,
                      ),
                    ),
                    child: ValueListenableBuilder(
                        valueListenable: _update,
                        builder: (_, value, __) {
                          return ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            controller: _scrollController,
                            children: montaCombo(),
                          );
                        }),
                  ),
                  Visibility(
                    visible: (_show.value && (widget.onPressedButton != null)),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      width: largura,
                      height: 50,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: () {
                            if (widget.onPressedButton != null) {
                              _show.value = false;
                              widget.onPressedButton!();
                            }
                          },
                          icon: Icon(Icons.add,
                              size: 30,
                              color: Theme.of(context).iconTheme.color),
                          label: Text('Adicionar Opção',
                              style: Theme.of(context).textTheme.headline3),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
