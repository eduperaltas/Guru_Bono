import 'package:flutter/material.dart';

import '../../core/framework/globals.dart';

class ScreenBase extends StatelessWidget {
  final Widget body;
  const ScreenBase({Key key, this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Container(
            alignment: Alignment.center,
            child: Image.asset('assets/imgs/guru_logo.png',
                height: ScreenWH(context).height * 0.15,
                width: ScreenWH(context).width * 0.3),
          ),
          backgroundColor: Colors.white,
        ),
        body: body);
  }
}
