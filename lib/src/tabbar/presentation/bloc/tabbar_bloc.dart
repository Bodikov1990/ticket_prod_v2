import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tabbar_event.dart';
part 'tabbar_state.dart';

class TabbarBloc extends Bloc<TabbarEvent, TabbarState> {
  TabbarBloc() : super(const TabSelected(0)) {
    on<TabUpdated>((event, emit) {
      emit(TabSelected(event.tabIndex));
    });
  }
}
