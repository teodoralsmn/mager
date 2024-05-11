import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mager/shared/firestore/money_management_firestore.dart';
import 'package:mager/shared/function/money_changer.dart';
import 'package:mager/shared/models/transaction_model.dart';
import 'package:mager/shared/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class HomeMainVM extends BaseViewModel {
  DateTime selectedDate = DateTime.now();
  DateTime selectedMonth = DateTime.now();

  int selectedIndex = 0;

  List<TransactionModel> dataDaily = [];
  bool loadingDaily = false;

  List<TransactionModelGrouping> dataMonthly = [];
  bool loadingMonthly = false;

  String getLabelDate() {
    if (selectedIndex == 0) {
      return DateFormat('dd/MM/yyyy').format(selectedDate);
    } else {
      String monthvalue = '';

      switch (selectedMonth.month) {
        case 1:
          monthvalue = 'January';
          break;
        case 2:
          monthvalue = 'February';
          break;
        case 3:
          monthvalue = 'March';
          break;
        case 4:
          monthvalue = 'April';
          break;
        case 5:
          monthvalue = 'May';
          break;
        case 6:
          monthvalue = 'June';
          break;
        case 7:
          monthvalue = 'July';
          break;
        case 8:
          monthvalue = 'August';
          break;
        case 9:
          monthvalue = 'September';
          break;
        case 10:
          monthvalue = 'October';
          break;
        case 11:
          monthvalue = 'November';
          break;
        case 12:
          monthvalue = 'December';
          break;
        default:
      }

      return "$monthvalue ${selectedMonth.year}";
    }
  }

  onChangeIndex(BuildContext context, int value) {
    selectedIndex = value;

    if (value == 0) {
      onLoadDataDaily(context);
    } else {
      onLoadDataMonthly(context);
    }

    notifyListeners();
  }

  onLoadDataDaily(BuildContext context) {
    loadingDaily = true;
    notifyListeners();
    MoneyManagementFirestore.getDataTransactionByDate(
            Provider.of<UserProvider>(context, listen: false).data!.uid,
            date: DateFormat('dd/MM/yyyy').format(selectedDate))
        .then((value) {
      loadingDaily = false;
      dataDaily = value;
      notifyListeners();
    });
  }

  onLoadDataMonthly(BuildContext context) {
    loadingMonthly = true;
    notifyListeners();
    MoneyManagementFirestore.getDataTransactionByMonth(
            Provider.of<UserProvider>(context, listen: false).data!.uid,
            date: DateFormat('MM/yyyy').format(selectedMonth))
        .then((value) {
      loadingMonthly = false;
      dataMonthly = value;
      notifyListeners();
    });
  }

  onNextAction(BuildContext context) {
    if (selectedIndex == 0) {
      selectedDate.add(const Duration(days: 1));
      onLoadDataDaily(context);
    } else {
      selectedMonth = DateTime(
          selectedMonth.month == 12
              ? selectedMonth.year + 1
              : selectedMonth.year,
          selectedMonth.month == 12 ? 1 : selectedMonth.month + 1);
      onLoadDataMonthly(context);
    }

    notifyListeners();
  }

  onPrevAction(BuildContext context) {
    if (selectedIndex == 0) {
      selectedDate.subtract(const Duration(days: 1));
      onLoadDataDaily(context);
    } else {
      selectedMonth = DateTime(
          selectedMonth.month == 1
              ? selectedMonth.year - 1
              : selectedMonth.year,
          selectedMonth.month == 1 ? 12 : selectedMonth.month - 1);
      onLoadDataMonthly(context);
    }

    notifyListeners();
  }

  String getIncomeByListTransaction(List<TransactionModel> data) {
    int total = 0;

    for (var i = 0; i < data.length; i++) {
      if (data[i].type == 0) {
        total = total + data[i].amount;
      }
    }

    return moneyChanger(total.toDouble());
  }

  String getExpensesByListTransaction(List<TransactionModel> data) {
    int total = 0;

    for (var i = 0; i < data.length; i++) {
      if (data[i].type == 1) {
        total = total + data[i].amount;
      }
    }

    return moneyChanger(total.toDouble());
  }

  String getIncomeTotal() {
    if (selectedIndex == 0) {
      int total = 0;

      for (var i = 0; i < dataDaily.length; i++) {
        if (dataDaily[i].type == 0) {
          total = total + dataDaily[i].amount;
        }
      }

      return moneyChanger(total.toDouble());
    } else {
      int total = 0;

      for (var i = 0; i < dataMonthly.length; i++) {
        for (var j = 0; j < dataMonthly[i].data.length; j++) {
          if (dataMonthly[i].data[j].type == 0) {
            total = total + dataMonthly[i].data[j].amount;
          }
        }
      }

      return moneyChanger(total.toDouble());
    }
  }

  String getExpensesTotal() {
    if (selectedIndex == 0) {
      int total = 0;

      for (var i = 0; i < dataDaily.length; i++) {
        if (dataDaily[i].type == 1) {
          total = total + dataDaily[i].amount;
        }
      }

      return moneyChanger(total.toDouble());
    } else {
      int total = 0;

      for (var i = 0; i < dataMonthly.length; i++) {
        for (var j = 0; j < dataMonthly[i].data.length; j++) {
          if (dataMonthly[i].data[j].type == 1) {
            total = total + dataMonthly[i].data[j].amount;
          }
        }
      }

      return moneyChanger(total.toDouble());
    }
  }
}
