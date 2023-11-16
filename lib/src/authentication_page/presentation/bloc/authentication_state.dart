// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class CheckPingState extends AuthenticationState {
  const CheckPingState();
}

class CheckedPingSuccesState extends AuthenticationState {
  const CheckedPingSuccesState();
}

class CheckedPingErrorState extends AuthenticationState {
  final String message;
  final int statusCode;
  const CheckedPingErrorState(
    this.message,
    this.statusCode,
  );

  @override
  List<Object> get props => [message, statusCode];
}

class CheckAuthenticationState extends AuthenticationState {
  const CheckAuthenticationState();
}

class CheckedAuthenticationState extends AuthenticationState {
  final UserModel user;
  const CheckedAuthenticationState(
    this.user,
  );

  @override
  List<Object> get props => [user];
}

class AuthenticatingState extends AuthenticationState {
  const AuthenticatingState();
}

class AuthenticatedState extends AuthenticationState {
  const AuthenticatedState();
}

class AuthenticationErrorState extends AuthenticationState {
  final String message;
  final int statusCode;
  const AuthenticationErrorState(
    this.message,
    this.statusCode,
  );

  @override
  List<Object> get props => [message, statusCode];
}

class CheckedAuthenticationErrorState extends AuthenticationState {
  final String? login;
  final String? password;

  const CheckedAuthenticationErrorState(
      {required this.login, required this.password});

  @override
  List<Object> get props => [login ?? '', password ?? ''];
}
