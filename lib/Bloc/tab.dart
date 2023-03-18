import 'package:flutter_bloc/flutter_bloc.dart';

class TabCubit extends Cubit<int> {
  TabCubit() : super(0);

  void tabUpdate({required int index}) {
    emit(index);
  }
}
