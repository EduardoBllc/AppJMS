import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/product.dart';

class Helper{
  DateTime cloudTimeStampToDateTime(Timestamp timestamp){
    DateTime dateTimeResult = DateTime.now();

    try {
      int timestampMilli = timestamp.millisecondsSinceEpoch;
      dateTimeResult = DateTime.fromMillisecondsSinceEpoch(timestampMilli);
    } catch (e) {
      log(e.toString());
    }
    return dateTimeResult;
  }
}