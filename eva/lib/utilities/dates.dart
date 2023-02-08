import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime dateObject) {
  final curDay = DateTime.now();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(dateObject);
  debugPrint(formatted); // something like 2013-04-20

  // final String formattedDate = curDay.weekday

  return formatted;
}
