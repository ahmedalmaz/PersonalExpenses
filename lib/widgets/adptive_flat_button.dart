import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveFlatButton extends StatelessWidget {
  final String buttonTitle;
  final Function handler;

  AdaptiveFlatButton(this.buttonTitle, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: handler,
            child: Text(
              buttonTitle,
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          )
        : FlatButton(
            onPressed: handler,
            child: Text(buttonTitle,
                style: TextStyle(color: Theme.of(context).primaryColor)),
          );
  }
}
