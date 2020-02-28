import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class BottomNavigationEvent extends Equatable {
  BottomNavigationEvent([List props = const []]) : super(props);
}

class PageTapped extends BottomNavigationEvent {
  final int index;

  PageTapped({@required this.index}) : super([index]);

  @override
  String toString() => 'PageTapped: $index';
}
