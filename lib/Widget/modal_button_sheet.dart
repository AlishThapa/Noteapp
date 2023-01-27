import 'package:flutter/material.dart';


class modal_button_sheet extends StatelessWidget {

  final Icon icon;
  final String name;

  modal_button_sheet({required this.icon, required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        icon,
        Text(name),
      ],
    );
  }
}
