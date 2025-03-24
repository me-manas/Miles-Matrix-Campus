import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:matrix_campus/main.dart';

void devLogger({required var message, bool? isError}) {
  if (kDebugMode) {
    (isError != true) ? logger.i(message) : logger.e(message);
  }
}

class Utils {
  static void showToast({
    required String message,
    Toast toastLength = Toast.LENGTH_SHORT,
  }) {
    Fluttertoast.showToast(msg: message, toastLength: toastLength);
  }
}
