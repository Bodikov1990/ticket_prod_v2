class AuthenticationEntity {
  final String? login;
  final String? password;

  AuthenticationEntity({required this.login, required this.password});

  AuthenticationEntity.empty()
      : this(login: "_empty.login", password: "_empty.password");
}
