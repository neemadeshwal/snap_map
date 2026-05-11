import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snapmap/core/error/exception.dart';
import 'package:snapmap/features/onboarding/data/model/user_setup_model.dart';

abstract class UserSetupRemoteDatasource {
  Future<void> saveUserSetup({required UserSetupModel userSetup});
}

class UserSetupRemoteDatasourcesImpl implements UserSetupRemoteDatasource {
  final FirebaseFirestore firestore;

  UserSetupRemoteDatasourcesImpl({required this.firestore});
  @override
  Future<void> saveUserSetup({required UserSetupModel userSetup}) async {
    try {
      await firestore.collection('users').doc(userSetup.userId).set({
        'onboardingComplete': true,
        'userSetup': userSetup.toJson(),
      }, SetOptions(merge: true));
    } on FirebaseException catch (e) {
      throw UserSetupException(e.message ?? 'Failed to save user setup');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
