import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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

class CalendarPageLoaded extends BottomNavigationState {
  final String text;

  CalendarPageLoaded({@required this.text}) : super([text]);

  @override
  String toString() => 'CalendarPageLoaded with text: $text';
}

class SecondPageLoaded extends BottomNavigationState {
  final int number;

  SecondPageLoaded({@required this.number}) : super([number]);

  @override
  String toString() => 'SecondPageLoaded with number: $number';
}
