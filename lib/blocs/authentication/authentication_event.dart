import 'package:equatable/equatable.dart';
import 'package:jsos_helper/common/university.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  final String token;
  final String username;
  final University university;

  LoggedIn(
      {@required this.token,
      @required this.username,
      @required this.university})
      : super([token, username, university]);

  @override
  String toString() =>
      'LoggedIn { token: $token, username: $username, university: $university }';
}

class LoggedOut extends AuthenticationEvent {
  @override
  String toString() => 'LoggedOut';
}
