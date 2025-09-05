import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_config.dart';
import 'package:mdpe_approve_app/features/home/domain/model/ConsAllocationModel.dart';
import 'package:mdpe_approve_app/service/Apis.dart';
import 'package:mdpe_approve_app/service/api_helper.dart';

class HomeHelper {
  static Future<ConsAllocationModel?> contractorAllocation({
    required BuildContext context,
  }) async {
    String schema =
        await AppConfig.instanceInit()!.loginData.user?.schema! ?? "";
    ;
    String userRole =
        await AppConfig.instanceInit()!.loginData.user?.role! ?? "";
    ;
    String userId = await AppConfig.instanceInit()!.loginData.user?.id! ?? "";
    ;
    Map<String, String> para = {
      "schema": schema,
      "role": userRole,
      "user_id": userId,
    };
    print("-------------->${Apis.contractorAllocation}");
    try {
      var res = await ApiHelper.postData(
        urlEndPoint: Apis.contractorAllocation,
        body: para,
        context: context,
      );
      if (res != null) {
        return ConsAllocationModel.fromJson(res);
      }
    } catch (e) {
      log("ConsAllocationModel-->${e.toString()}");
    }
    return null;
  }
}
