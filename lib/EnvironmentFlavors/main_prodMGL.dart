import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/enums.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/environment_config.dart';
import 'package:mdpe_approve_app/root.dart';

main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var configurationApp = EnvironmentConfig(
      flavors: EnvironmentFlavors.prodMGL,
      child: Root(client: Client.mahaNagar));
  runApp(configurationApp);
}
