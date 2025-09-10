import 'package:flutter/material.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_color.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_config.dart';

class AppString {
  static String version = "Version : ${AppConfig.instanceInit()?.appName}-${AppConfig.instanceInit()?.appVersion},10-9-2025";
  static String companyName = "© Unistal Systems Pvt. Ltd.";
  static String emailLabel = "Enter User Email";
  static String passwordLabel = "Enter User Password";
  static String emailValidation = "Please enter email id";
  static String passwordValidation = "Please enter password";
  static String submit = "Submit";
  static String yes = "Yes";
  static String no = "No";
  static String login = "Login";
  static String logout = "Logout";
  static String logoutMsg = "Are you sure you want to logout? Once you logout, you will be return to login screen";
  static String star = "* ";
  static String approval = "Approve";
  static String reject = "Reject";
  static String remarks = "Remark";
  static const String mdpeApp = 'MDPE Approval APP';
}
