import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/AppNavigator.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_color.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_config.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/enums.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/singleton.dart';
import 'package:mdpe_approve_app/features/ApprovalDetails/domain/bloc/approval_details_bloc.dart';
import 'package:mdpe_approve_app/features/Login/domain/bloc/login_bloc.dart';
import 'package:mdpe_approve_app/features/Login/presentation/login_view.dart';
import 'package:mdpe_approve_app/features/UserApprovalList/domain/bloc/user_approval_list_bloc.dart';
import 'package:mdpe_approve_app/features/home/presentation/home_page.dart';
import 'features/Splash/presentation/splash_view.dart';
import 'features/UserApprovalList/presentation/user_approval_list_view.dart';
import 'features/home/domain/bloc/home_bloc.dart';



class Root extends StatefulWidget {
  final Client client;
  const Root({required this.client});
  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {

  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Singleton.instanceInit()?.context = context;
    AppConfig.instanceInit()!.setClient(client: widget.client);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColor.primer));
    return MultiBlocProvider (
        providers: [
          BlocProvider(create: (BuildContext context) => LoginBloc()),
          BlocProvider(create: (BuildContext context) => HomeBloc()),
          BlocProvider(create: (BuildContext context) => UserApprovalListBloc()),
          BlocProvider(create: (BuildContext context) => ApprovalDetailsBloc()),
        ],
        child: MaterialApp(
          navigatorKey: AppNavigator.navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppColor.primer,
            hintColor: AppColor.primer,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColor.primer,
            ),
          ),
         home: SplashView(),
          routes: {
            '/splash': (_) => SplashView(),
            '/login': (_) => LoginView(),
            '/home': (_) => HomePage(),
            '/userApprovalListView': (_) => UserApprovalListView(),
          },
        ));
  }
}