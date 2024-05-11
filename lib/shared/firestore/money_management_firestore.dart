import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mager/shared/firestore/firestore_helper.dart';
import 'package:mager/shared/models/transaction_model.dart';

class MoneyManagementFirestore {
  static Future<List<TransactionModelGrouping>> getDataTransactionByMonth(
      String uid,
      {required String date}) async {
    QuerySnapshot<Map<String, dynamic>> result =
        await FirestoreHelper.getCollection(FirestoreHelper.userCollection)
            .doc(uid)
            .collection(FirestoreHelper.transactionCollection)
            .get();

    List<QueryDocumentSnapshot> dataRaw = [];

    for (var i = 0; i < result.docs.length; i++) {
      if (result.docs[i].data()['date'].toString().substring(2) == date) {
        dataRaw.add(result.docs[i]);
      }
    }

    return transactionGrouping(List.generate(result.docs.length, (index) {
      return TransactionModel(
          id: result.docs[index].id,
          amount: result.docs[index].data()['amount'],
          date: result.docs[index].data()['date'],
          type: result.docs[index].data()['type'],
          notes: result.docs[index].data()['notes'],
          category: result.docs[index].data()['category']);
    }));
  }

  static Future<List<TransactionModel>> getDataTransactionByDate(String uid,
      {required String date}) async {
    QuerySnapshot<Map<String, dynamic>> result =
        await FirestoreHelper.getCollection(FirestoreHelper.userCollection)
            .doc(uid)
            .collection(FirestoreHelper.transactionCollection)
            .where('date', isEqualTo: date)
            .get();

    return List.generate(result.docs.length, (index) {
      return TransactionModel(
          id: result.docs[index].id,
          amount: result.docs[index].data()['amount'],
          date: result.docs[index].data()['date'],
          type: result.docs[index].data()['type'],
          notes: result.docs[index].data()['notes'],
          category: result.docs[index].data()['category']);
    });
  }

  static Future<bool> saveTransaction(
      {required int amount,
      required String uid,
      required String date,
      required int type,
      required String category,
      String? notes}) async {
    try {
      await FirestoreHelper.getCollection(FirestoreHelper.userCollection)
          .doc(uid)
          .collection(FirestoreHelper.transactionCollection)
          .add({
        'amount': amount,
        'type': type,
        'date': date,
        'category': category,
        'notes': notes
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}
