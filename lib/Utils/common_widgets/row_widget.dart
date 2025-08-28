import 'package:flutter/material.dart';

import 'res/app_style.dart';

class RowWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const RowWidget({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
        CommonStyle.widthSpace(context: context),
        Flexible(
          flex: 1,
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.green.shade800,
            ),
          ),
        ),
      ],
    );
  }
}
