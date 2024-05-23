part of 'main_app_bloc.dart';

abstract class MainAppEvent extends Equatable {
  const MainAppEvent();

  @override
  List<Object> get props => [];
}

class MainChangeLocaleEvent extends MainAppEvent {
  final Locale locale;

  const MainChangeLocaleEvent(this.locale);

  @override
  List<Object> get props => [locale];
}

class MainGetSavedLocaleEvent extends MainAppEvent {}
