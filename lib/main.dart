import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jsos_helper/blocs/authentication/authentication.dart';
import 'package:jsos_helper/blocs/bottom_navigation/bottom_navigation.dart';
import 'package:jsos_helper/common/connection_status_singleton.dart';
import 'package:jsos_helper/repositories/storage_repository.dart';
import 'package:jsos_helper/ui/components/loading_indicator.dart';
import 'package:jsos_helper/ui/screens/login_screen.dart';
import 'package:jsos_helper/ui/screens/main_screen.dart';
import 'package:jsos_helper/ui/screens/splash_screen.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

// TODO - initializeDateFormatting
void main() {
  ConnectionStatusSingleton connectionStatus =
      ConnectionStatusSingleton.getInstance();
  connectionStatus.initialize();

  BlocSupervisor.delegate = SimpleBlocDelegate();
  final _storageRepository = StorageRepository();
  initializeDateFormatting().then((_) => runApp(
        BlocProvider<AuthenticationBloc>(
          builder: (context) {
            return AuthenticationBloc(storageRepository: _storageRepository)
              ..dispatch(AppStarted());
          },
          child: App(storageRepository: _storageRepository),
        ),
      ));
}

class App extends StatelessWidget {
  final StorageRepository storageRepository;

  App({Key key, @required this.storageRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // TODO - create custom ui.theme and choose colors
        primaryColor: Colors.red[900],
        accentColor: Colors.amber[600],
      ),
      home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        builder: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticationUninitialized) {
            return SplashScreen();
          }
          if (state is AuthenticationAuthenticated) {
            return BlocProvider(
              builder: (context) {
                return BottomNavigationBloc();
              },
              child: MainScreen(storageRepository: storageRepository),
            );
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(storageRepository: storageRepository);
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          return Container();
        },
      ),
    );
  }
}
