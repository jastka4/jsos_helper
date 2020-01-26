import 'package:equatable/equatable.dart';
import 'package:jsos_helper/common/university.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;
  final University university;

  LoginButtonPressed({
    @required this.username,
    @required this.password,
    @required this.university,
  }) : super([username, password, university]);

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password, university: $university }';
}
