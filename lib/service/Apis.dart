import 'package:flutter/material.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/environment_config.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/singleton.dart';

class Apis {

  static BuildContext? context = Singleton.instanceInit()?.context;

  static final String baseUrl =
      EnvironmentConfig.of(context!)!.generalUrlBaseFlavour;
  // static String baseUrl = 'http://142.79.231.30:9097/api/';
 // static String baseUrl = 'http://pbgpl.smartgasnet.com/api/';
 // static String baseUrl = 'https://nmpplstations1.smartgasnet.com/api/';

  static get loginUrl =>  "auth";
  static get areaList => "getAllArea?schema=";
  static get getFeasibilityApi => "getfeasibilityapi?";
  static get getLMCInstallationApi => "getLMCInstallationPbglApi?";
  static get getNGCApi => "NGClmcInstallationTpapbgplapi?";
  static get updateFeasStatus => "updatefeasStatus";
  static get updateInstallationStatus => "UpdateTpaStatusPbgpl";
  static get updateNGCStatus => "NGClmcTpaApprovePbgpl";

  ////////////////  MDPE Approval  ////////////////

static get mdpeApprovalList => "get-mdpe-pmc-data?";
static get contractorAllocation => "get-contractor-allocation";
static get savePmcApproval => "save-pmc-approval";

}
