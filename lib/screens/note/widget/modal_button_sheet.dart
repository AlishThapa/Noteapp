import 'package:flutter/material.dart';

class ModalButtonSheet extends StatelessWidget {
  final Icon icon;
  final String name;

  const ModalButtonSheet({super.key, required this.icon, required this.name});

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
