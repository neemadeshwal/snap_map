import 'package:flutter_test/flutter_test.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/features/auth/domain/usecases/sign_in_with_email.dart';

import 'fake_auth_repository.dart';

void main() {
  late SignInWithEmail signInWithEmailUsecase;
  late FakeAuthRepository fakeRepository;

  setUp(() {
    fakeRepository = FakeAuthRepository();
    signInWithEmailUsecase = SignInWithEmail((fakeRepository));
  });

  test('should return Right(UserEntity) on successful sigin', () async {
    const params = SigninParams(
      email: 'test@example.com',
      password: 'password123',
    );

    final result = await signInWithEmailUsecase(params);

    expect(result.isRight(), true);
    result.fold((failure) => fail('Should not return failure'), (user) {
      expect(user.email, equals('test@example.com'));
      expect(user.uid, equals('user123'));
    });
  });

  test('should return Left(failure) when signin fails', () async {
    fakeRepository.shouldThrowError = true;
    const params = SigninParams(
      email: 'test@example.com',
      password: 'wrongpassword',
    );

    final result = await signInWithEmailUsecase(params);
    expect(result.isLeft(), true);
    result.fold((failure) {
      expect(failure, isA<AuthFailure>());
    }, (user) => fail('should not return user'));
  });
  test('should pass email correctly to repository', () async {
    const email = 'custom@example.com';
    const params = SigninParams(email: email, password: 'password123');
    final result = await signInWithEmailUsecase(params);
    result.fold((failure) => fail('Should not fail'), (user) {
      expect(user.email, equals(email));
    });
  });
}
