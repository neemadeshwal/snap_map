import 'package:flutter_test/flutter_test.dart';
import 'package:snapmap/core/error/failure.dart';
import 'package:snapmap/features/auth/data/repository/auth_repository_impl.dart';

import 'fake_auth_datasource.dart';

void main() {
  group('AuthRepositoryImpl', () {
    late AuthRepositoryImpl repository;
    late FakeAuthDatasource fakeDatasource;

    setUp(() {
      fakeDatasource = FakeAuthDatasource();
      repository = AuthRepositoryImpl(remoteDatasource: fakeDatasource);
    });
    group('signInWithEmail', () {
      test('should return Right(UserEntity) on success', () async {
        const email = 'test@example.com';
        const password = 'password123';

        final result = await repository.signInWithEmail(
          email: email,
          password: password,
        );

        expect(result.isRight(), true);
        result.fold((failure) => fail('Should not return failure'), (user) {
          expect(user.email, equals(email));
          expect(user.uid, equals('user123'));
        });
      });
      test('should return Left(UserEntity)', () async {
        fakeDatasource.shouldThrowError = true;
        const email = 'test@example.com';
        const password = 'password123';

        final result = await repository.signInWithEmail(
          email: email,
          password: password,
        );
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure, isA<AuthFailure>());
        }, (user) => fail('Should not return user'));
      });
    });
    group('signUpWithEmail', () {
      test('should return Right(UserEntity) on success', () async {
        const email = 'newuser@example.com';
        const password = 'password123';
        const name = 'New User';

        final result = await repository.signUpWithEmail(
          email: email,
          password: password,
          name: name,
        );
        expect(result.isRight(), true);
        result.fold((failure) => fail('Should not return failure'), (user) {
          expect(user.email, equals(email));
          expect(user.name, equals(name));
        });
      });
    });
    test('should return Left(failure) on error', () async {
      fakeDatasource.shouldThrowError = true;

      final result = await repository.signUpWithEmail(
        email: 'test@example.com',
        password: 'password123',
        name: 'Test User',
      );
      expect(result.isLeft(), true);
    });
    group('signout', () {
      test('should return right(null) on success', () async {
        final result = await repository.signOut();

        expect(result.isRight(), true);
      });
      test('should return Left(failure) on error', () async {
        fakeDatasource.shouldThrowError = true;
        final result = await repository.signOut();
        expect(result.isLeft(), true);
      });
    });
    group('getCurrentUser', () {
      test('should return Right(UserEntity) when user exists', () async {
        final result = await repository.getCurrentUser();
        expect(result.isRight(), true);
        result.fold((failure) => fail('Should not return failure'), (user) {
          expect(user, isNotNull);
          expect(user?.uid, equals('user123'));
        });
      });
      test('should return Left(failure) on error', () async {
        fakeDatasource.shouldThrowError = true;
        final result = await repository.getCurrentUser();

        expect(result.isLeft(), true);
      });
    });

    group('signInWithGoogle', () {
      test('should return Right(UserEntity) on success', () async {
        final result = await repository.signinWithGoogle();
        result.fold((failure) => fail('Should not return failure'), (user) {
          expect(user.email, equals('google@gmail.com'));
        });
      });
      test('should return Left(Failure ) on error', () async {
        fakeDatasource.shouldThrowError = true;
        final result = await repository.signinWithGoogle();
        expect(result.isLeft(), true);
      });
    });

    group('isBiometricAvailable', () {
      test('should return true when biometric is available ', () async {
        final result = await repository.isBiometricAvailable();

        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('should not return failure'),
          (available) => expect(available, true),
        );
      });
      test('should return Left(failure) on error', () async {
        fakeDatasource.shouldThrowError = true;
        final result = await repository.isBiometricAvailable();
        expect(result.isLeft(), true);
      });
    });

    group('forgotPassword', () {
      test('should return Right(null) on success', () async {
        final result = await repository.forgotPassword(
          email: 'test@example.com',
        );
        expect(result.isRight(), true);
      });
      test('should return Left(failure) on error', () async {
        fakeDatasource.shouldThrowError = true;
        final result = await repository.forgotPassword(
          email: 'test@example.com',
        );
        expect(result.isLeft(), true);
      });
    });
  });
}
