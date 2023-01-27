import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/Bloc/tab.dart';
import '../../Bloc/note_bloc.dart';
import '../../Models/note_list.dart';
import '../../Widget/modal_button_sheet.dart';
import '../new_and_update_note.dart';
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
    tabcontroller.addListener(
      () {
        context.read<TabCubit>().tabUpdate(index: tabcontroller.index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final time = DateTime.now();
    return BlocBuilder<NoteAppCubit, List<NoteList>>(
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
            BlocBuilder<TabCubit,int>(
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
                      : ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 10,
                          ),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewandUpdateNotes(
                                    titlE: state[index].title,
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
                                        modal_button_sheet(icon: const Icon(Icons.lock), name: 'Hide'),
                                        modal_button_sheet(icon: const Icon(Icons.arrow_downward), name: 'Unpin'),
                                        modal_button_sheet(icon: const Icon(Icons.add), name: 'Move to'),
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
                                                        )),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                        context.read<NoteAppCubit>().deleteNote(index: index);
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
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(8),
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
                          ),
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
