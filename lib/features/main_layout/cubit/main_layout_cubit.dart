import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_layout_state.dart';


class MainLayoutCubit extends Cubit<int> {
  MainLayoutCubit() : super(0);

  void changeTab(int index) => emit(index);
  void backToHome() => emit(0);
}
