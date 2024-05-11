import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mager/shared/firestore/firestore_helper.dart';
import 'package:mager/shared/models/category_model.dart';

class CategoryFirestore {
  static Future<List<CategoryModel>> getCategoryList(String uid) async {
    QuerySnapshot<Map<String, dynamic>> result =
        await FirestoreHelper.getCollection(FirestoreHelper.userCollection)
            .doc(uid)
            .collection(FirestoreHelper.categoryCollection)
            .get();

    return List.generate(result.docs.length, (index) {
      return CategoryModel(
          id: result.docs[index].id,
          category: result.docs[index].data()['data']);
    });
  }

  static Future<bool> saveCategoryData(
      {required String data, required String uid, String? categoryId}) async {
    try {
      if (categoryId == null) {
        await FirestoreHelper.getCollection(FirestoreHelper.userCollection)
            .doc(uid)
            .collection(FirestoreHelper.categoryCollection)
            .add({'data': data});
      } else {
        await FirestoreHelper.getCollection(FirestoreHelper.userCollection)
            .doc(uid)
            .collection(FirestoreHelper.categoryCollection)
            .doc(categoryId)
            .update({'data': data});
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> deleteCategory(
      {required String uid, required String categoryId}) async {
    try {
      await FirestoreHelper.getCollection(FirestoreHelper.userCollection)
          .doc(uid)
          .collection(FirestoreHelper.categoryCollection)
          .doc(categoryId)
          .delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
