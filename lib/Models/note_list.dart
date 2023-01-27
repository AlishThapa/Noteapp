import 'dart:core';
import 'package:flutter/material.dart';

class NoteList {
  String title;
  String description;

  NoteList({required this.title, required this.description});

  NoteList copyWith({String? title, String? description}) {
    return NoteList(
        title: title ?? this.title,
        description: description ?? this.description);
  }
}
