import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

// TODO - Change toString method to log important data
@immutable
abstract class BottomNavigationState extends Equatable {
  BottomNavigationState([List props = const []]) : super(props);
}

class CurrentIndexChanged extends BottomNavigationState {
  final int currentIndex;

  CurrentIndexChanged({@required this.currentIndex}) : super([currentIndex]);

  @override
  String toString() => 'CurrentIndexChanged to $currentIndex';
}

class PageLoading extends BottomNavigationState {
  @override
  String toString() => 'PageLoading';
}

class HomePageLoaded extends BottomNavigationState {
  final int number;

  HomePageLoaded({@required this.number}) : super([number]);

  @override
  String toString() => 'HomePageLoaded with number: $number';
}

class CalendarPageLoaded extends BottomNavigationState {
  final String text;

  CalendarPageLoaded({@required this.text}) : super([text]);

  @override
  String toString() => 'CalendarPageLoaded with text: $text';
}

class GradesPageLoaded extends BottomNavigationState {
  final int number;

  GradesPageLoaded({@required this.number}) : super([number]);

  @override
  String toString() => 'GradesPageLoaded with number: $number';
}

class MessagesPageLoaded extends BottomNavigationState {
  final int number;

  MessagesPageLoaded({@required this.number}) : super([number]);

  @override
  String toString() => 'MessagesPageLoaded with number: $number';
}

class PaymentsPageLoaded extends BottomNavigationState {
  final int number;

  PaymentsPageLoaded({@required this.number}) : super([number]);

  @override
  String toString() => 'PaymentsPageLoaded with number: $number';
}
