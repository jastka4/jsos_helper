import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsos_helper/blocs/bottom_navigation/bottom_navigation.dart';
import 'package:jsos_helper/ui/components/bottom_navigation.dart';
import 'package:jsos_helper/ui/screens/calendar_scree.dart';
import 'package:jsos_helper/ui/screens/splash_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<BottomNavigationEvent, BottomNavigationState>(
        bloc: BlocProvider.of<BottomNavigationBloc>(context),
        builder: (BuildContext context, BottomNavigationState state) {
          // TODO - add additional pages
          if (state is PageLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is FirstPageLoaded) {
            return CalendarScreen(title: 'Calendar');
          }
          if (state is SecondPageLoaded) {
            return SplashScreen();
          }
          return Container();
        },
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
