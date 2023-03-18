import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/screens/note/db/db_modals/db_modal.dart';
import 'package:noteapp/screens/note/db/database_service_noteapp.dart';
import 'note_bloc/note_bloc.dart';
import 'models/note_list.dart';

class NewAndUpdateNotes extends StatefulWidget {
  NewAndUpdateNotes({Key? key, this.des, this.titlee, this.index}) : super(key: key);

  String? des;
  String? titlee;
  int? index;

  @override
  State<NewAndUpdateNotes> createState() => _NewAndUpdateNotesState();
}

class _NewAndUpdateNotesState extends State<NewAndUpdateNotes> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    if (widget.des != null) {
      setState(() {
        description.text = widget.des!;
        title.text = widget.titlee!;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    description.clear();
    title.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Description is needed'),
    );
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          GestureDetector(
            onTap: () async {
              if (description.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if (widget.index != null) {
                context.read<NoteAppCubit>().updateNote(note: NoteModel(title: title.text, description: description.text), index: widget.index!);
                Navigator.pop(context);
                return;
              } else {
                DatabaseService().create(
                  DatabaseModel(
                    title: title.text.trim(),
                    description: description.text.trim(),
                  ),
                );

                description.clear();
                title.clear();
                context.read<NoteAppCubit>().addNote();
                Navigator.pop(context);
              }
            },
            child: const Icon(
              Icons.check,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        // physics:const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              color: Colors.black26,
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                controller: title,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add Title',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: MediaQuery.of(context).size.height,
              color: Colors.black12,
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                controller: description,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add Description',
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
