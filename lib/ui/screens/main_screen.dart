import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsos_helper/blocs/bottom_navigation/bottom_navigation.dart';
import 'package:jsos_helper/repositories/storage_repository.dart';
import 'package:jsos_helper/ui/components/bottom_navigation.dart';

import 'screens.dart';

class MainScreen extends StatelessWidget {
  final StorageRepository storageRepository;

  MainScreen({Key key, @required this.storageRepository}) : super(key: key);

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
            return HomeScreen(storageRepository: storageRepository);
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
