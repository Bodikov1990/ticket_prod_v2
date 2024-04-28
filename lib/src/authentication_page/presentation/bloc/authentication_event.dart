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
  final String expiredAt;

  const AuthenticateEvent(
      {required this.login, required this.password, required this.expiredAt});

  @override
  List<Object> get props => [login, password, expiredAt];
}

class SaveAuthenticationDataEvent extends AuthenticationEvent {
  final String accessToken;

  const SaveAuthenticationDataEvent({required this.accessToken});

  @override
  List<Object> get props => [accessToken];
}
