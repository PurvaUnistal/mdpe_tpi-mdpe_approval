import 'package:flutter/material.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_color.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_string.dart';
import 'package:mdpe_approve_app/Utils/common_widgets/res/app_styles.dart';

import 'res/app_config.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
                decoration: BoxDecoration(color: AppColor.primer),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Text(
                      AppString.companyName,
                      textAlign: TextAlign.start,
                      style: Styles.rel,
                    )),
                    Flexible(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          AppString.version,
                          textAlign: TextAlign.start,
                          style: Styles.rel,
                        ),
                        AppConfig.instanceInit()?.loginData.user == null
                            ? SizedBox.shrink()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    AppConfig.instanceInit()
                                            ?.loginData
                                            .user!
                                            .name! ??
                                        "",
                                    textAlign: TextAlign.start,
                                    style: Styles.rel,
                                  ),
                                  Text(
                                    " (${AppConfig.instanceInit()?.loginData.user!.schema! ?? ""})",
                                    textAlign: TextAlign.start,
                                    style: Styles.rel,
                                  ),
                                ],
                              ),
                      ],
                    )),
                  ],
                )))
      ],
    );
  }
}
