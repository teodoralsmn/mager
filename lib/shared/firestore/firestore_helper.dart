import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHelper {
  static String userCollection = 'users';
  static String categoryCollection = 'category';
  static String transactionCollection = 'transaction';

  static CollectionReference<Map<String, dynamic>> getCollection(
      String collection) {
    return FirebaseFirestore.instance.collection(collection);
  }
}
