part of 'tabbar_bloc.dart';

sealed class TabbarEvent extends Equatable {
  const TabbarEvent();

  @override
  List<Object> get props => [];
}

class TabUpdated extends TabbarEvent {
  final int tabIndex;

  const TabUpdated(this.tabIndex);

  @override
  List<Object> get props => [tabIndex];
}
