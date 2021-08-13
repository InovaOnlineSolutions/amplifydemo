abstract class AuthCredentials {
  final String username;
  final String password;
  final String phone;
  AuthCredentials({this.username, this.password, this.phone});
}

// 2
class LoginCredentials extends AuthCredentials {
  LoginCredentials({String username, String password})
      : super(username: username, password: password);
}

// 3
class SignUpCredentials extends AuthCredentials {


  SignUpCredentials({String username, String password, phone})
      : super(username: username, password: password, phone: phone);
}
