import 'package:flutter/material.dart';

class StyleModel {
  String headname;
  String tailname;
  Icon icon;

  StyleModel({required this.headname, required this.tailname, required this.icon});
}

List<StyleModel> styleModel = [
  StyleModel(headname: 'Font Size', tailname: 'Medium', icon: const Icon(Icons.arrow_downward)),
  StyleModel(headname: 'Sort', tailname: 'By modification date', icon: const Icon(Icons.arrow_downward)),
];
