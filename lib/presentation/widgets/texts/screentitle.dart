import 'package:guru_bono/core/framework/colors.dart';
import 'package:guru_bono/core/framework/globals.dart';
import 'package:flutter/material.dart';

class ScreenTitle extends StatelessWidget {
  final String title;
  const ScreenTitle({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 10, left: 15),
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
                margin: const EdgeInsets.only(bottom: 15),
                height: 3,
                width: ScreenWH(context).width * 0.35,
                decoration: const BoxDecoration(
                  color: greenSoft,
                )),
          )
        ],
      ),
    );
  }
}
