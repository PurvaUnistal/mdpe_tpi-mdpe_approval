import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_config.dart';
import 'package:mdpe_approve_app/features/UserApprovalList/domain/model/getMdpePmcDataModel.dart';
import 'package:mdpe_approve_app/service/Apis.dart';
import 'package:mdpe_approve_app/service/api_server_dio.dart';

class UserApprovalListHelper {
  static Future<GetMdpePmcDataModel?> mdpeApprovalList({
    required BuildContext context,
  }) async {
    String schema =  await AppConfig.instanceInit()!.loginData.user?.schema! ?? "";;
    String userRole =  await AppConfig.instanceInit()!.loginData.user?.role! ?? "";;
    String contractId =  await AppConfig.instanceInit()!.allocationData.contractId ?? "";
    Map<String, String> para = {
      "schema": schema,
      "role": userRole,
      "contract_id": contractId,
    };
    String json = Uri(queryParameters: para).query;
    print('--------------->${json}');
    try {
      var res = await ApiHelper.getData(
          urlEndPoint: Apis.mdpeApprovalList + json, context: context);
      if (res != null) {
        return GetMdpePmcDataModel.fromJson(res);
      }
    } catch (e) {
      log("mdpeApprovalList-->${e.toString()}");
    }
    return null;
  }
}
