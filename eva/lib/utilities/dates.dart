import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime dateObject) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(dateObject);
  debugPrint(formatted);

  return formatted;
}
