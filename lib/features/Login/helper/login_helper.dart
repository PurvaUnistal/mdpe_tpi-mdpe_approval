import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/flutter_toast.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_config.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_string.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/enums.dart';
import 'package:mdpe_approve_app/features/Login/domain/model/login_model.dart';
import 'package:mdpe_approve_app/service/Apis.dart';
import 'package:mdpe_approve_app/service/api_server_dio.dart';

class LoginHelper {
  static Future<dynamic> textFieldValidation(
      {required String email,
      required String password,
      required BuildContext context}) async {
    try {
      if (email.isEmpty) {
        UtilsToast.errorSnackBar(
            msg: AppString.emailValidation, context: context);
        return false;
      } else if (password.isEmpty) {
        UtilsToast.errorSnackBar(
            msg: AppString.passwordValidation, context: context);
        return false;
      }
      return true;
    } catch (e) {
      log(e.toString());
      UtilsToast.errorSnackBar(msg: e.toString(), context: context);
      return false;
    }
  }

  static getUniqueDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    }
    return null;
  }

  static Future<LoginModel?> loginData(
      {required String emailId,
      required String password,
      required BuildContext context}) async {
    var deviceId = await getUniqueDeviceId();
    Map<String, String> para = {
      "email": emailId,
      "password": password,
      "device": deviceId,
    };
    try {
      var res = await ApiHelper.postData(
          urlEndPoint: Apis.loginUrl, param: para, context: context);
      if (res == null) return null;
      if (!res["error"]) {
        if (AppConfig.instanceInit()!.client == Client.purbaBharti &&
                res["user"]["role"] == "mdpe pmc" ||
            res["user"]["role"] == "mdpe client" ||
            AppConfig.instanceInit()!.client == Client.mahaNagar &&  res["user"]["role"] == "tpi") {
          await UtilsToast.successSnackBar(
              msg: res["messages"], context: context);
          String baseUrl = Apis.loginUrl.replaceAll("api/auth", "");

          return LoginModel.fromJson(res);
        } else {
          UtilsToast.errorSnackBar(
              msg: "Invalid role ID. Please check your credentials.",
              context: context);
          return null;
        }
      }
      if (res["messages"] != null) {
        await UtilsToast.errorSnackBar(msg: res["messages"], context: context);
      }
      return null;
    } catch (e) {
      log("catchLoginHelper --> ${e.toString()}");
      UtilsToast.errorSnackBar(
          msg: "An error occurred: ${e.toString()}", context: context);
      return null;
    }
  }
}
