part of 'main_app_bloc.dart';

class MainAppState extends Equatable {
  final Locale locale;

  const MainAppState(this.locale);

  factory MainAppState.initial() {
    return const MainAppState(Locale('ru'));
  }

  MainAppState copyWith(Locale locale) {
    return MainAppState(locale);
  }

  @override
  List<Object> get props => [locale];
}
