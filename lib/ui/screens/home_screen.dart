import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsos_helper/blocs/authentication/authentication.dart';
import 'package:jsos_helper/blocs/bottom_navigation/bottom_navigation.dart';
import 'package:jsos_helper/ui/components/bottom_navigation.dart';
import 'package:jsos_helper/ui/screens/splash_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: BlocBuilder<BottomNavigationEvent, BottomNavigationState>(
        bloc: BlocProvider.of<BottomNavigationBloc>(context),
        builder: (BuildContext context, BottomNavigationState state) {
          // TODO - add additional pages
          if (state is PageLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is FirstPageLoaded) {
            return Container(
              child: Center(
                  child: RaisedButton(
                child: Text('logout'),
                onPressed: () {
                  authenticationBloc.dispatch(LoggedOut());
                },
              )),
            );
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
