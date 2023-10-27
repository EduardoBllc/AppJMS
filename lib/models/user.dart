class AppUser{
  AppUser({
    required this.email,
    required this.password,
    required this.username,
  });

  final String email;
  final String password;
  final String username;

  set email(String email) => email;

  set password(String password) => password;

  set username(String username) => username;
}