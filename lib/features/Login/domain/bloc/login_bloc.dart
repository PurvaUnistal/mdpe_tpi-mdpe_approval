import 'dart:convert';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/AppNavigator.dart';
import 'package:mdpe_approve_app/features/Login/presentation/login_view.dart';
import 'package:mdpe_approve_app/features/home/presentation/home_page.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/SharedPerfs/Prefs_Value.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/SharedPerfs/preference_utils.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/connectivity_helper.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_config.dart';
import 'package:mdpe_approve_app/features/Login/domain/bloc/login_event.dart';
import 'package:mdpe_approve_app/features/Login/domain/bloc/login_state.dart';
import 'package:mdpe_approve_app/features/Login/domain/model/login_model.dart';
import 'package:mdpe_approve_app/features/Login/helper/login_helper.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitState()) {
    on<LoginPageLoadingEvent>(_pageLoad);
    on<LoginSetEmailIdEvent>(_setEmailId);
    on<LoginSetPasswordEvent>(_setPassword);
    on<LoginHideShowPasswordEvent>(_setHideShowPassword);
    on<LoginSubmitDataEvent>(_setSubmitLoginData);
  }

  bool isPageLoader = false;
  bool isPassword = false;

  String emailId = "";
  String password = "";
  String deviceId = "";
  LoginModel loginModel = LoginModel();

  _pageLoad(LoginPageLoadingEvent event, emit) async {
    emailId = "";
    password = "";
    deviceId = "";
    isPassword = true;
    isPageLoader = false;
    loginModel = LoginModel();
    _eventCompleted(emit);
  }

  _setEmailId(LoginSetEmailIdEvent event, emit) {
    emailId = event.emailId.toString().replaceAll(" ", "");
  }

  _setPassword(LoginSetPasswordEvent event, emit) {
    password = event.password.toString().replaceAll(" ", "");
  }

  _setHideShowPassword(LoginHideShowPasswordEvent event, emit) {
    isPassword = event.isHideShow;
    _eventCompleted(emit);
  }

  _setSubmitLoginData(LoginSubmitDataEvent event, emit) async {
    if (await ConnectivityHelper.allConnectivityCheck(context: event.context) ==
        false) {
      return;
    }
    var validationCheck = await LoginHelper.textFieldValidation(
      email: emailId,
      password: password,
      context: event.context,
    );
    if (validationCheck == true) {
      try {
        isPageLoader = true;
        _eventCompleted(emit);
        var res = await LoginHelper.loginData(
          emailId: emailId,
          password: password,
          context: event.context,
        );
        if (res != null) {
          isPageLoader = false;
          _eventCompleted(emit);
          if (res.user != null) {
            loginModel = res;
            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            String buildNumber = packageInfo.buildNumber;
            await SharedPref.setString(key: PrefsValue.buildNumber, value: buildNumber,);
            await SharedPref.setString(key: PrefsValue.passwordVal, value: password,);
            await SharedPref.setString(key: PrefsValue.emailVal, value: emailId,);
            String userJson = jsonEncode(res.toJson());
            await SharedPref.setString(key: PrefsValue.userInfo, value: userJson,);
            final appConfig = AppConfig.instanceInit();
            if (appConfig != null) {
              await appConfig.setLoginData(newLoginData: loginModel);
            }
            if (res.status == 200) {
              AppNavigator.pushReplacement(HomePage());
            }
          }
        } else {
          isPageLoader = false;
          _eventCompleted(emit);
        }
      } catch (e) {
        isPageLoader = false;
        _eventCompleted(emit);
        log("catchLoginBloc-->${e.toString()}");
      }
    }
    _eventCompleted(emit);
  }

  _eventCompleted(Emitter<LoginState> emit) {
    emit(
      LoginFetchDataState(isPageLoader: isPageLoader, isPassword: isPassword),
    );
  }
}
