import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/flutter_toast.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_config.dart';
import 'package:mdpe_approve_app/features/ApprovalDetails/domain/Model/UpdateStatusModel.dart';
import 'package:mdpe_approve_app/service/Apis.dart';
import 'package:mdpe_approve_app/service/api_server_dio.dart';

class ApprovalDetailsHelper {
  static Future<UpdateStatusModel?> savePmcApproval({
    required BuildContext context,
    required String layingId,
    required String actualLength,
    required String image,
    required String status,
    required String remarks,
  }) async {
    String schema =
        await AppConfig.instanceInit()?.loginData.user!.schema! ?? "";
    String userId = await AppConfig.instanceInit()?.loginData.user!.id! ?? "";
    String role = await AppConfig.instanceInit()?.loginData.user!.role! ?? "";
    try {
      Map<String, String> para = {
        "schema": schema,
        "user_id": userId,
        "role": role,
        "laying_id": layingId,
        "actual_length": actualLength,
        "status": status,
        "remarks": remarks,
      };
      log("para-->${para}");
      var res = await ApiHelper.postDataWithFile(
        urlEndPoint: Apis.savePmcApproval,
        body: para,
        context: context,
        imageRequestObject: [ImageRequestObject("penumatic_image", image)],
      );

      if (res != null) {
        UtilsToast.successSnackBar(msg: res["data"], context: context);
        return UpdateStatusModel.fromJson(res);
      }
    } catch (e) {
      log("savePmcApproval-->${e.toString()}");
      return null;
    }
    return null;
  }
}
