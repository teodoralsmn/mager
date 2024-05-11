import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:mager/app/settings/category_page.dart';
import 'package:mager/shared/firestore/money_management_firestore.dart';
import 'package:mager/shared/function/show_snackbar.dart';
import 'package:mager/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class MoneyFormVM extends BaseViewModel {
  int selectedType = 0;
  String? selecetedCategory;

  TextEditingController amountController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  onChangeDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now().add(const Duration(days: 365)));

    if (picked != null) {
      selectedDate = picked;
      notifyListeners();
    }
  }

  onChangeType(int value) {
    selectedType = value;
    notifyListeners();
  }

  onPickCategory(BuildContext context) async {
    String? result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => const CategoryPage(
                  isPicker: true,
                )));

    if (result != null) {
      selecetedCategory = result;
      notifyListeners();
    }
  }

  onSave(BuildContext context) {
    String? validation;

    if (amountController.text.isEmpty) {
      validation = 'Please Enter amount';
    }

    if (selecetedCategory == null) {
      validation = 'Please pick category';
    }

    if (validation == null) {
      EasyLoading.show();
      MoneyManagementFirestore.saveTransaction(
              type: selectedType,
              amount: int.parse(amountController.text.replaceAll('.', '')),
              uid: Provider.of<UserProvider>(context, listen: false).data!.uid,
              date: DateFormat('dd/MM/yyyy').format(selectedDate),
              category: selecetedCategory!,
              notes: notesController.text.isEmpty ? null : notesController.text)
          .then((value) {
        EasyLoading.dismiss();
        if (value) {
          Navigator.pop(context, true);
          showSnackbar(context,
              message: 'Successfully add transaction',
              customColor: Colors.green);
        } else {
          showSnackbar(context,
              message: 'Failed to add transaction', customColor: Colors.orange);
        }
      });
    } else {
      showSnackbar(context, message: validation, customColor: Colors.orange);
    }
  }
}
