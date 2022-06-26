import 'package:guru_bono/core/framework/colors.dart';
import 'package:flutter/material.dart';

import '../../../core/framework/globals.dart';

class CircularImg extends StatelessWidget {
  const CircularImg({Key key, this.pathImg = '', this.vHeight, this.vWidth})
      : super(key: key);
  final String pathImg;
  final double vHeight;
  final double vWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: vHeight ?? 55,
        width: vWidth ?? 55,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: greenPrimary, width: 2.5)),
        child: CircleAvatar(
          backgroundImage: AssetImage(pathImg),
          backgroundColor: Colors.white,
        ));
  }
}
