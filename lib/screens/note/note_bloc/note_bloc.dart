import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/screens/note/db/database_service_noteapp.dart';
import '../models/note_list.dart';

class NoteAppCubit extends Cubit<List<NoteModel>> {
  NoteAppCubit() : super([]);

  void updateNote({required NoteModel note, required int index}) {
    List<NoteModel> notes = [...state];
    notes[index] = note;
    emit(notes);
  }

  void addNote() async {
    List<NoteModel> notes = await DatabaseService().readNote();
    emit(notes);
  }

  void deleteNote({required int index}) {
    List<NoteModel> noteTitle = [...state];
    noteTitle.removeAt(index);
    emit(noteTitle);
  }
}
