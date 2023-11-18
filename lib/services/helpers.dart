import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../models/product.dart';

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

  static String realCurrencyFormatter(double value) {
    return 'R\$${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }
}
