class TransactionModelGrouping {
  late String date;
  List<TransactionModel> data = [];

  TransactionModelGrouping({required this.data, required this.date});
}

List<TransactionModelGrouping> transactionGrouping(
    List<TransactionModel> data) {
  List<TransactionModelGrouping> dataFinal = [];

  for (var i = 0; i < data.length; i++) {
    int? foundIndex;

    for (var j = 0; j < dataFinal.length; j++) {
      if (dataFinal[j].date == data[i].date) {
        foundIndex = j;
      }
    }

    if (foundIndex == null) {
      dataFinal
          .add(TransactionModelGrouping(data: [data[i]], date: data[i].date));
    } else {
      dataFinal[foundIndex].data.add(data[i]);
    }
  }

  return dataFinal;
}

class TransactionModel {
  late String id;
  late int amount;
  late String date;
  late int type;
  late String category;
  String? notes;

  TransactionModel(
      {required this.amount,
      required this.id,
      required this.type,
      required this.date,
      required this.category,
      this.notes});
}
