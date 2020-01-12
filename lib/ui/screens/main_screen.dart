import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsos_helper/blocs/bottom_navigation/bottom_navigation.dart';
import 'package:jsos_helper/ui/components/bottom_navigation.dart';

import 'screens.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavigationEvent, BottomNavigationState>(
        bloc: BlocProvider.of<BottomNavigationBloc>(context),
        builder: (BuildContext context, BottomNavigationState state) {
          if (state is PageLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is HomePageLoaded) {
            return HomeScreen();
          }
          if (state is CalendarPageLoaded) {
            return CalendarScreen(title: 'Calendar');
          }
          if (state is GradesPageLoaded) {
            return GradesScreen(title: 'Grades');
          }
          if (state is MessagesPageLoaded) {
            return MessagesScreen(title: 'Messages');
          }
          if (state is PaymentsPageLoaded) {
            return PaymentsScreen(title: 'Payments');
          }
          return Container();
        },
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
