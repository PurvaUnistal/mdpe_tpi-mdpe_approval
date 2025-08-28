import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/AppNavigator.dart';
import 'package:mdpe_approve_app/features/Login/presentation/login_view.dart';
import 'package:mdpe_approve_app/features/UserApprovalList/presentation/user_approval_list_view.dart';
import 'package:mdpe_approve_app/features/home/presentation/home_page.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/Routes/routes_name.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_asset.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_color.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_config.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/enums.dart';
import 'package:mdpe_approve_app/features/Login/domain/model/login_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _getData();
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    toLogin();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> toLogin() async {

    final email = await SharedPref.getString(key: PrefsValue.emailVal);
    final password = await SharedPref.getString(key: PrefsValue.passwordVal);
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final newVersion  = await packageInfo.buildNumber;
    AppConfig.instanceInit()?.setAppVersion(appVersion: packageInfo.buildNumber);
    AppConfig.instanceInit()?.setAppName(appName:  packageInfo.appName);
    final oldVersion = await SharedPref.getString(key: PrefsValue.buildNumber);
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      if (oldVersion == newVersion && (email.isNotEmpty || password.isNotEmpty)) {
        AppNavigator.pushReplacement(HomePage());
      } else {
        AppNavigator.pushReplacement(LoginView());
      }
    });
  }

  Future<LoginModel?> _getData() async {
    try {
      String? userJson = await SharedPref.getString(key: PrefsValue.userInfo ?? "");
      if (userJson != '') {
        Map<String, dynamic> userMap = jsonDecode(userJson!);
        LoginModel loginModel = LoginModel.fromJson(userMap);
        final appConfig = AppConfig.instanceInit();
        if (appConfig != null) {
          await appConfig.setLoginData(newLoginData: loginModel);
        }
        return loginModel;
      }
    } catch (e) {
      debugPrint("Error in _getData: $e");
    }
    return null;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              AppConfig.instanceInit()!.client == Client.purbaBharti
                  ? AppIcon.pbgplLogo
                  :AppConfig.instanceInit()!.client == Client.mahaNagar
                  ? AppIcon.mglLogo
                  : AppIcon.pbgplLogo,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.6,
            ),
          ),
        ),
      ),
    );
  }
}
