import 'package:mdpe_approve_app/Utils/common_widgets/res/enums.dart';
import 'package:mdpe_approve_app/features/Login/domain/model/login_model.dart';
import 'package:mdpe_approve_app/features/UserApprovalList/domain/model/getMdpePmcDataModel.dart';
import 'package:mdpe_approve_app/features/home/domain/model/ConsAllocationModel.dart';

class AppConfig {
  static AppConfig? instance;


  static AppConfig? instanceInit() {
    instance ??= AppConfig();
    return instance;
  }

  Client? client;
  AllocationData allocationData = AllocationData();
  MdpePmcData mdpePmcData = MdpePmcData();
  LoginModel loginData = LoginModel();

  String _appVersion = "";
  String get appVersion => _appVersion;

  String _appName = "";
  String get appName => _appName;

  String _packageName = "";
  String get packageName => _packageName;


  setClient({required Client client}) {
    this.client = client;
  }
  setAllocationData({required AllocationData allocationData}) {
    this.allocationData = allocationData;
  }

  setMdpePmcData({required MdpePmcData newMdpePmcData}) {
    this.mdpePmcData = newMdpePmcData;
  }

  setLoginData({required LoginModel newLoginData}) {
    this.loginData = newLoginData;
  }
  void setAppVersion({required String appVersion}) {
    _appVersion = appVersion;
    print("appVersion : $_appVersion");
  }

  void setAppName({required String appName}) {
    _appName = appName;
    print("appName : $appName");
  }

  void setPackageName({required String packageName}) {
    _packageName = packageName;
    print("packageName : $packageName");
  }
}