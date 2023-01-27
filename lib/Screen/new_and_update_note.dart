import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Bloc/note_bloc.dart';
import '../Models/note_list.dart';

class NewandUpdateNotes extends StatefulWidget {
  NewandUpdateNotes({Key? key, this.des, this.titlE, this.index}) : super(key: key);

  String? des;
  String? titlE;
  int? index;

  @override
  State<NewandUpdateNotes> createState() => _NewandUpdateNotesState();
}

class _NewandUpdateNotesState extends State<NewandUpdateNotes> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if(widget.des != null){
      setState(() {
        description.text = widget.des!;
        title.text = widget.titlE!;
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
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
            onTap: () {
              if (description.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else if(widget.index!=null){
                 context.read<NoteAppCubit>().updateNote(note: NoteList(title: title.text, description: description.text), index: widget.index!);
                 Navigator.pop(context);

                 return;
              }else {
                context.read<NoteAppCubit>().addNote(
                  title: NoteList(
                    title: title.text.trim(),
                    description: description.text.trim(),
                  ),
                );
                description.clear();
                title.clear();
                Navigator.pop(context);
              }

            },
            child: const Icon(Icons.check,color: Colors.black,),
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
                controller:title,
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
                controller:description ,
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
