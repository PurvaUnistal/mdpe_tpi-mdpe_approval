import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class UtilsToast {

  static Future<void> successSnackBar({ required String msg,  required BuildContext context}) async {
    Fluttertoast.showToast(
      msg: msg,
        backgroundColor: Colors.green,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0
    );

  }
  static  Future<void> errorSnackBar({ required String msg,  required BuildContext context}) async {
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: Colors.red,
        toastLength: Toast.LENGTH_LONG,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0
    );
  }

}
