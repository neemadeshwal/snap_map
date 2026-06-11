import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:snapmap/core/constants/app_constants.dart';
import 'package:snapmap/core/error/exception.dart';
import 'package:snapmap/features/onboarding/data/model/user_setup_model.dart';
import 'package:http/http.dart' as http;

abstract class UserSetupRemoteDatasource {
  Future<void> saveUserSetup({required UserSetupModel userSetup});
  Future<String> uploadAvatar(String localPath);
  Future<bool> isUsernameAvailable(String username);
}

class UserSetupRemoteDatasourcesImpl implements UserSetupRemoteDatasource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  UserSetupRemoteDatasourcesImpl({required this.firestore, required this.auth});
  @override
  Future<void> saveUserSetup({required UserSetupModel userSetup}) async {
    try {
      String? avatarUrl;

      if (userSetup.profileLocalPath != null &&
          userSetup.profileLocalPath!.isNotEmpty) {
        print('uploading avatar from path: ${userSetup.profileLocalPath}');
        avatarUrl = await uploadAvatar(userSetup.profileLocalPath!);
        print('avatar uploaded, url: $avatarUrl');
      }

      print('saving to firestore...');
      final json = userSetup.copyWith(profilePhoto: avatarUrl).toJson();
      print('json: $json'); // ← this will show exactly what's failing

      final batch = firestore.batch();
      batch.set(firestore.collection('users').doc(userSetup.userId), {
        'onboardingComplete': true,
        'userSetup': json,
      });

      batch.set(
        firestore.collection('usernames').doc(userSetup.username.toLowerCase()),
        {'uid': userSetup.userId},
      );
      await batch.commit();
    } on FirebaseException catch (e) {
      throw UserSetupException(e.message ?? 'Failed to save user setup');
    } catch (e, stackTrace) {
      print('error: $e');
      print('stackTrace: $stackTrace'); // ← shows exact line number
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadAvatar(String localPath) async {
    try {
      final request =
          http.MultipartRequest('POST', Uri.parse(AppConstants.uploadUrl))
            ..fields['upload_preset'] = 'snapmap_photos'
            ..fields['folder'] = 'avatars'
            ..files.add(await http.MultipartFile.fromPath('file', localPath));

      final response = await request.send();
      final body = await response.stream.bytesToString();
      final json = jsonDecode(body);

      if (response.statusCode != 200) {
        throw UserSetupException(
          json['error']?['message'] ?? 'Failed to upload avatar',
        );
      }
      return json['secure_url'];
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<bool> isUsernameAvailable(String username) async {
    try {
      final doc = await firestore
          .collection('usernames')
          .doc(username.toLowerCase())
          .get();
      return !doc.exists;
    } catch (e, stackTrace) {
      print('error: $e');
      print('stackTrace: $stackTrace'); // ← shows exact line number
      throw ServerException(e.toString());
    }
  }
}
