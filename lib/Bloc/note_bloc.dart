import 'package:flutter_bloc/flutter_bloc.dart';

import '../Models/note_list.dart';

class NoteAppCubit extends Cubit<List<NoteList>> {
  NoteAppCubit() : super([]);

  void updateNote({required NoteList note,
    required int index}) {
    List<NoteList> notes = [...state];
    notes[index] = note;
   emit(notes);
  }

  void addNote({
    required NoteList title,
  }) {
    List<NoteList> notetitle = [...state];
    notetitle.add(title);
    emit(notetitle);
  }

  void deleteNote({required int index}) {
    List<NoteList> notetitle = [...state];
    notetitle.removeAt(index);
    emit(notetitle);
  }
}
