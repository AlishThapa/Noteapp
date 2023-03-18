import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/Bloc/tab.dart';
import 'package:noteapp/screens/note/db/database_service_noteapp.dart';
import 'note_bloc/note_bloc.dart';
import 'models/note_list.dart';
import 'widget/modal_button_sheet.dart';
import 'new_and_update_note.dart';
import 'package:intl/intl.dart';

class Notes extends StatefulWidget {
  const Notes({Key? key}) : super(key: key);

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> with TickerProviderStateMixin {
  late TabController tabcontroller;

  @override
  void initState() {
    tabcontroller = TabController(length: 2, vsync: this, initialIndex: context.read<TabCubit>().state);
    super.initState();
    context.read<NoteAppCubit>().addNote();
    tabcontroller.addListener(
      () {
        context.read<TabCubit>().tabUpdate(index: tabcontroller.index);
      },
    );
  }

  final _lightColors = [
    Colors.amber.shade300,
    Colors.lightGreen.shade300,
    Colors.lightBlue.shade300,
    Colors.orange.shade300,
    Colors.pinkAccent.shade100,
    Colors.tealAccent.shade100
  ];

  @override
  Widget build(BuildContext context) {
    final time = DateTime.now();
    return BlocBuilder<NoteAppCubit, List<NoteModel>>(
      builder: (context, state) => Container(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(left: 30),
              height: 30,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search notes',
                  hintStyle: TextStyle(
                    color: Colors.grey.withOpacity(0.9),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<TabCubit, int>(
              builder: (context, tabIndex) => TabBar(
                isScrollable: true,
                padding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                indicatorColor: Colors.transparent,
                indicatorWeight: 1,
                labelColor: Colors.white,
                physics: const BouncingScrollPhysics(),
                controller: tabcontroller,
                tabs: [
                  Container(
                    alignment: Alignment.center,
                    height: 25,
                    width: 40,
                    decoration: BoxDecoration(
                      color: tabIndex == 0 ? Colors.grey.shade400 : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'All',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 25,
                    width: 40,
                    decoration: BoxDecoration(
                      color: tabIndex == 0 ? Colors.transparent : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.folder,
                      color: Colors.orange,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: TabBarView(
                controller: tabcontroller,
                children: [
                  state.isEmpty
                      ? const SizedBox()
                      : GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.length,
                          itemBuilder: (context, index) {
                            final color = _lightColors[index % _lightColors.length];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewAndUpdateNotes(
                                      titlee: state[index].title,
                                      des: state[index].description,
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                              onLongPress: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      padding: const EdgeInsets.all(10),
                                      height: 60,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const ModalButtonSheet(icon: Icon(Icons.lock), name: 'Hide'),
                                          const ModalButtonSheet(icon: Icon(Icons.arrow_downward), name: 'Unpin'),
                                          const ModalButtonSheet(icon: Icon(Icons.add), name: 'Move to'),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog<void>(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: const Text('Delete note'),
                                                    content: SingleChildScrollView(
                                                      child: ListBody(
                                                        children: const [
                                                          Text('Delete note?'),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          width: 100,
                                                          padding: const EdgeInsets.all(10),
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(15),
                                                          ),
                                                          child: const Text('Cancel'),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          DatabaseService().delete(state[index].id!);
                                                          context.read<NoteAppCubit>().addNote();
                                                          Navigator.pop(context);
                                                          Navigator.pop(context);
                                                        },
                                                        child: Container(
                                                          alignment: Alignment.center,
                                                          width: 100,
                                                          padding: const EdgeInsets.all(10),
                                                          decoration: BoxDecoration(
                                                            color: Colors.blue,
                                                            borderRadius: BorderRadius.circular(15),
                                                          ),
                                                          child: const Text('Delete'),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                            child: Column(
                                              children: const [
                                                Icon(
                                                  Icons.delete,
                                                ),
                                                Text('Delete'),
                                              ],
                                            ),
                                          ),
                                          // modal_button_sheet(icon: const Icon(Icons.delete),name: 'Delete',)
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                  left: index.isOdd ? 6.0 : 0.0,
                                  right: index.isEven ? 6.0 : 0.0,
                                  bottom: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: color,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      state[index].title,
                                      style: const TextStyle(fontSize: 20),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      state[index].description,
                                      style: const TextStyle(color: Colors.black45),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      DateFormat.yMMMd().format(time),
                                      style: const TextStyle(fontSize: 10),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                  const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
