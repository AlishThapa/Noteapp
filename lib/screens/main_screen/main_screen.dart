import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/Bloc/tab.dart';
import 'package:noteapp/screens/main_screen/setting_page/settings.dart';
import '../todo/to_do_app.dart';
import '../todo/widget/todo_widget.dart';
import '../note/new_and_update_note.dart';
import '../note/note_all.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController bartabcontroller;
  int activeTabIndex = 0;
  TextEditingController todo = TextEditingController();

  @override
  void initState() {
    bartabcontroller = TabController(length: 2, vsync: this, initialIndex: activeTabIndex);
    super.initState();
    bartabcontroller.addListener(() {
      setState(() {
        activeTabIndex = bartabcontroller.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: BlocBuilder<TabCubit, int>(
          builder: (context, tabIndex) => tabIndex == 1
              ? const SizedBox()
              : FloatingActionButton(
                  backgroundColor: Colors.orange,
                  onPressed: () {
                    activeTabIndex == 0
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewAndUpdateNotes(),
                            ),
                          )
                        : showModalBottomSheet(
                            isDismissible: true,
                            context: context,
                            builder: (context) {
                              return TodoWidget(todo: todo);
                            },
                          );
                  },
                  child: const Icon(Icons.add),
                ),
        ),
        body: Container(
          color: Colors.grey.withOpacity(0.2),
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.settings, color: Colors.transparent),
                  TabBar(
                    isScrollable: true,
                    padding: EdgeInsets.zero,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 20),
                    indicatorColor: Colors.transparent,
                    indicatorWeight: 1,
                    labelColor: Colors.white,
                    controller: bartabcontroller,
                    tabs: [
                      Icon(
                        Icons.note_alt_outlined,
                        color: activeTabIndex == 0 ? Colors.orange : Colors.grey,
                      ),
                      Icon(
                        Icons.check_box_rounded,
                        color: activeTabIndex == 0 ? Colors.grey : Colors.orange,
                      )
                    ],
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Settings(),
                          ),
                        );
                      },
                      child: const Icon(Icons.settings)),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: bartabcontroller,
                  children: const [
                    Notes(),
                    TodoPage(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
