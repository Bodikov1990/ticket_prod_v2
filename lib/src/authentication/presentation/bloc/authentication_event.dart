part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class CheckPingEvent extends AuthenticationEvent {}

class CheckAuthenticationEvent extends AuthenticationEvent {
  const CheckAuthenticationEvent();
}

class AuthenticateEvent extends AuthenticationEvent {
  final String login;
  final String password;

  const AuthenticateEvent({required this.login, required this.password});

  @override
  List<Object> get props => [login, password];
}

class SaveAuthenticationDataEvent extends AuthenticationEvent {
  final String accessToken;

  const SaveAuthenticationDataEvent({required this.accessToken});

  @override
  List<Object> get props => [accessToken];
}
