import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:jsos_helper/blocs/authentication/authentication_event.dart';

import 'bottom_navigation_event.dart';
import 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
//  final FirstPageRepository firstPageRepository;
//  final SecondPageRepository secondPageRepository;
  int currentIndex = 0;

  BottomNavigationBloc();

//  BottomNavigationBloc({this.firstPageRepository, this.secondPageRepository})
//      : assert(firstPageRepository != null),
//        assert(secondPageRepository != null);

  @override
  BottomNavigationState get initialState => PageLoading();

  @override
  Stream<BottomNavigationState> mapEventToState(
      BottomNavigationEvent event) async* {
    if (event is AppStarted) {
      this.dispatch(PageTapped(index: this.currentIndex));
    }
    if (event is PageTapped) {
      this.currentIndex = event.index;
      yield CurrentIndexChanged(currentIndex: this.currentIndex);
      yield PageLoading();

      if (this.currentIndex == 0) {
        String data = await _getCalendarPageData();
        yield CalendarPageLoaded(text: data);
      }
      if (this.currentIndex == 1) {
        int data = await _getGradesPageData();
        yield GradesPageLoaded(number: data);
      }
      if (this.currentIndex == 2) {
        int data = await _getMessagesPageData();
        yield MessagesPageLoaded(number: data);
      }
    }
  }

  // TODO - log proper data
  Future<String> _getCalendarPageData() async {
//    String data = firstPageRepository.data;
//    if (data == null) {
//      await firstPageRepository.fetchData();
//      data = firstPageRepository.data;
//    }
//    return data;
    return "Testing";
  }

  Future<int> _getGradesPageData() async {
//    int data = secondPageRepository.data;
//    if (data == null) {
//      await secondPageRepository.fetchData();
//      data = secondPageRepository.data;
//    }
//    return data;
    return 1;
  }

  Future<int> _getMessagesPageData() async {
//    int data = secondPageRepository.data;
//    if (data == null) {
//      await secondPageRepository.fetchData();
//      data = secondPageRepository.data;
//    }
//    return data;
    return 2;
  }
}
