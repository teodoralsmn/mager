import 'package:intl/intl.dart';

String moneyChanger(double value, {String? customLabel}) {
  return NumberFormat.currency(
          name: customLabel ?? 'Rp', decimalDigits: 0, locale: 'id')
      .format(value.round());
}
