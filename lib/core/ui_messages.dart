import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UIMessages {
  UIMessages._();

  static Future<bool?> showSimpleToast(String message) {
    return Fluttertoast.showToast(
      msg: message,
    );
  }

  static Future<bool?> showErrToast(String message) {
    return Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.red,
    );
  }

  static void showNoNetworkConnectionToast() =>
      Fluttertoast.showToast(msg: 'Отсутствует соединение с интернетом');
}
