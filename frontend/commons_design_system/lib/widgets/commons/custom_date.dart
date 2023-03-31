import 'package:commons_deps/commons_deps.dart';
import 'package:flutter/material.dart';

class CustomDate extends StatelessWidget {
  final String title;

  final bool filled;
  final String? value;
  final void Function(String)? onChange;
  final double padding;
  const CustomDate({
    Key? key,
    required this.title,
    this.filled = false,
    this.value,
    this.onChange,
    this.padding = 8,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(title, style: Theme.of(context).textTheme.bodyText1),
        ),
        InkWell(
          onTap: () async {
            showDatePicker(
              initialEntryMode: DatePickerEntryMode.input,
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(DateTime.now().year + 50),
            ).then((date) {
              if ((date != null) && (onChange != null)) {
                onChange!(DateFormat('dd/MM/yyyy').format(date));
              }
            });
          },
          child: InputDecorator(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.date_range, size: 30),
              filled: filled,
            ),
            child: Text(
              value ?? '',
            ),
          ),
        ),
      ],
    );
  }
}
