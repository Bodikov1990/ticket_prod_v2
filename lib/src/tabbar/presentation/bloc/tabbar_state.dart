part of 'tabbar_bloc.dart';

sealed class TabbarState extends Equatable {
  const TabbarState();

  @override
  List<Object> get props => [];
}

final class TabbarInitial extends TabbarState {}

class TabSelected extends TabbarState {
  final int selectedTabIndex;

  const TabSelected(this.selectedTabIndex);

  @override
  List<Object> get props => [selectedTabIndex];
}
