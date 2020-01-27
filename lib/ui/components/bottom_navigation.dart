import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsos_helper/blocs/bottom_navigation/bottom_navigation.dart';

class BottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bottomNavigationBloc =
        BlocProvider.of<BottomNavigationBloc>(context);

    return BlocBuilder<BottomNavigationEvent, BottomNavigationState>(
        bloc: _bottomNavigationBloc,
        builder: (BuildContext context, BottomNavigationState state) {
          return BottomNavigationBar(
            currentIndex: _bottomNavigationBloc.currentIndex,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.black),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today, color: Colors.black),
                title: Text('Calendar'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.filter_5, color: Colors.black),
                title: Text('Grades'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.email, color: Colors.black),
                title: Text('Messages'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.attach_money, color: Colors.black),
                title: Text('Finances'),
              ),
            ],
            onTap: (index) =>
                _bottomNavigationBloc.dispatch(PageTapped(index: index)),
          );
        });
  }
}
