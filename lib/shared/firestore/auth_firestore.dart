import 'package:mager/shared/firestore/firestore_helper.dart';

class AuthFirestore {
  static Future<bool> changeProfile(
      {required String uid,
      required String phone,
      String? profilePicture}) async {
    try {
      await FirestoreHelper.getCollection(FirestoreHelper.userCollection)
          .doc(uid)
          .update({
        'phone': phone.isEmpty ? null : phone,
        'profile_picture': profilePicture,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> changePIN(
      {required String uid, required String pin}) async {
    try {
      await FirestoreHelper.getCollection(FirestoreHelper.userCollection)
          .doc(uid)
          .update({'pin': pin});
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> addUser({
    required String idAuth,
    required String email,
    required String name,
    required String ulangTahun,
  }) async {
    try {
      await FirestoreHelper.getCollection(FirestoreHelper.userCollection)
          .doc(idAuth)
          .set({
        'email': email,
        'name': name,
        'ulang_tahun' : ulangTahun,
        'phone': null,
        'profile_picture': null,
        'pin': null
      });
      return true;
    } catch (e) {
      return false;
    }
  }
}
