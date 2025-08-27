import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CupertinoAlertDialogWidget extends StatelessWidget {
  final Widget child;
  final Widget? content;
  const CupertinoAlertDialogWidget({Key? key, required this.child, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text('Are you sure?'),
      content : Material(child: content),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        child,
      ],
    );
  }
}
