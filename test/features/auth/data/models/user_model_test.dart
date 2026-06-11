import 'package:flutter_test/flutter_test.dart';
import 'package:snapmap/features/auth/data/models/user_model.dart';

void main() {
  group('UserModel', () {
    test('should create UserModel with correct values.', () {
      final userModel = UserModel(
        uid: 'user123',
        name: 'John Doe',
        email: 'john@example.com',
        phoneNumber: '1234567890',
        photoUrl: null,
        createdAt: DateTime(2024, 1, 1),
        lastLoginAt: null,
      );
      expect(userModel.uid, equals('user123'));
      expect(userModel.email, equals('john@example.com'));
      expect(userModel.name, equals('John Doe'));
    });
  });
}
