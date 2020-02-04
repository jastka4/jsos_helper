import 'package:flutter_test/flutter_test.dart';
import 'package:jsos_helper/blocs/authentication/authentication.dart';
import 'package:jsos_helper/blocs/login/login.dart';
import 'package:jsos_helper/common/university.dart';
import 'package:jsos_helper/repositories/user_repository.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {}

class MockAuthenticationBloc extends Mock implements AuthenticationBloc {}

void main() {
  LoginBloc loginBloc;
  MockUserRepository userRepository;
  MockAuthenticationBloc authenticationBloc;

  setUp(() {
    userRepository = MockUserRepository();
    authenticationBloc = MockAuthenticationBloc();
    loginBloc = LoginBloc(
      userRepository: userRepository,
      authenticationBloc: authenticationBloc,
    );
  });

  tearDown(() {
    loginBloc?.close();
    authenticationBloc?.close();
  });

  test('initial state is correct', () {
    expect(LoginInitial(), loginBloc.initialState);
  });

  test('close does not emit new states', () {
    expectLater(
      loginBloc,
      emitsInOrder([LoginInitial(), emitsDone]),
    );
    loginBloc.close();
  });

  group('LoginButtonPressed', () {
    test('emits token on success', () {
      final expectedResponse = [
        LoginInitial(),
        LoginLoading(),
        LoginInitial(),
      ];

      when(userRepository.authenticate(
        username: 'valid.username',
        password: 'valid.password',
        university: University.pwr,
      )).thenAnswer((_) => Future.value('token'));

      expectLater(
        loginBloc,
        emitsInOrder(expectedResponse),
      ).then((_) {
        verify(authenticationBloc.add(LoggedIn(
          token: 'token',
          university: University.pwr,
          username: 'valid.username',
        ))).called(1);
      });

      loginBloc.add(LoginButtonPressed(
        username: 'valid.username',
        password: 'valid.password',
        university: University.pwr,
      ));
    });
  });
}
