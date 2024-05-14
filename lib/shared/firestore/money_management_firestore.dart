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

    List<TransactionModel> dataRaw = [];

    for (var i = 0; i < result.docs.length; i++) {
      if (result.docs[i].data()['date'].toString().substring(3) == date) {
        dataRaw.add(TransactionModel(
            id: result.docs[i].id,
            amount: result.docs[i].data()['amount'],
            date: result.docs[i].data()['date'],
            type: result.docs[i].data()['type'],
            notes: result.docs[i].data()['notes'],
            category: result.docs[i].data()['category']));
      }
    }

    return transactionGrouping(dataRaw);
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
