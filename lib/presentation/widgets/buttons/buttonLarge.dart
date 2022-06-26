import 'dart:math';

import 'package:guru_bono/core/framework/colors.dart';
import 'package:guru_bono/core/framework/globals.dart';
import 'package:flutter/material.dart';

class ButtonLarge extends StatelessWidget {
  final String text;
  final Function onPressed;

  const ButtonLarge({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // button
    final buttonStyle = TextButton.styleFrom(
        backgroundColor: greenPrimary,
        primary: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))));

    return Container(
        margin: const EdgeInsets.all(10),
        width: ScreenWH(context).width * 0.85,
        child: TextButton(
          style: buttonStyle,
          child: Text(
            text,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                decoration: TextDecoration.none),
          ),
          onPressed: () => onPressed(),
        ));
  }
}
