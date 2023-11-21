import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Helper {
  static DateTime cloudTimeStampToDateTime(Timestamp timestamp) {
    DateTime dateTimeResult = DateTime.now();

    try {
      int timestampMilli = timestamp.millisecondsSinceEpoch;
      dateTimeResult = DateTime.fromMillisecondsSinceEpoch(timestampMilli);
    } catch (e) {
      log(e.toString());
    }
    return dateTimeResult;
  }

  static String localDateFormatter(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static double autoFormatToCurrency(String? value) {
    if (value!.isNotEmpty) {
      late String formattedValue = value.split('\$')[1].replaceAll(',', '.');
      if (formattedValue.length > 5) {
        for (int i = 2; i < formattedValue.length; i += 3) {
          formattedValue = formattedValue.replaceFirst('.', '');
        }
      }
      try {
        return double.parse(formattedValue);
      } catch (e) {
        // print(e);
        return 0.0;
      }
    }
    return 0.0;
  }

  static String realCurrencyFormatter(double value) {
    return 'R\$${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }
}
