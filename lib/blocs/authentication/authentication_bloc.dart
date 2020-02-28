import 'package:bloc/bloc.dart';
import 'package:jsos_helper/repositories/storage_repository.dart';
import 'package:meta/meta.dart';

import 'authentication.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final StorageRepository storageRepository;

  AuthenticationBloc({@required this.storageRepository})
      : assert(storageRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await storageRepository.hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await storageRepository.setToken(event.token);
      await storageRepository.setUsername(event.username);
      await storageRepository.setUniversity(event.university);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await storageRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
