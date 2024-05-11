import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mager/app/settings/widgets/category_form_dialog.dart';
import 'package:mager/shared/firestore/category_firestore.dart';
import 'package:mager/shared/function/show_snackbar.dart';
import 'package:mager/shared/function/yes_or_no_dialog.dart';
import 'package:mager/shared/models/category_model.dart';
import 'package:mager/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class CategoryVM extends BaseViewModel {
  List<CategoryModel> data = [];
  bool isLoading = false;

  onLoadDataCategory(BuildContext context) {
    isLoading = true;
    notifyListeners();
    CategoryFirestore.getCategoryList(
            Provider.of<UserProvider>(context, listen: false).data!.uid)
        .then((value) {
      data = value;
      isLoading = false;
      notifyListeners();
    });
  }

  onDeleteCategory(BuildContext context, CategoryModel data) async {
    yesOrNoDialog(context,
            title: 'Delete Category', desc: 'Are you sure to delete category?')
        .then((value) {
      if (value) {
        EasyLoading.show();
        CategoryFirestore.deleteCategory(
                uid:
                    Provider.of<UserProvider>(context, listen: false).data!.uid,
                categoryId: data.id)
            .then((result) {
          EasyLoading.dismiss();
          if (result) {
            onLoadDataCategory(context);
            showSnackbar(context,
                message: 'Successfully delete category',
                customColor: Colors.green);
          } else {
            showSnackbar(context,
                message: 'Failed to delete category',
                customColor: Colors.orange);
          }
        });
      }
    });
  }

  onCategoryAdd(BuildContext context, {CategoryModel? data}) async {
    String? result = await showDialog(
        context: context,
        builder: (context) {
          return CategoryFormDialog(
            initData: data?.category,
          );
        });

    if (result != null && context.mounted) {
      EasyLoading.show();
      CategoryFirestore.saveCategoryData(
              data: result,
              categoryId: data?.id,
              uid: Provider.of<UserProvider>(context, listen: false).data!.uid)
          .then((value) {
        EasyLoading.dismiss();
        if (value) {
          onLoadDataCategory(context);
          showSnackbar(context,
              message: 'Successfully add category', customColor: Colors.green);
        } else {
          showSnackbar(context,
              message: 'Failed to add category', customColor: Colors.orange);
        }
      });
    }
  }
}
