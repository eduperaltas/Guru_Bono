import 'package:guru_bono/core/framework/globals.dart';
import 'package:guru_bono/presentation/views/home/widgets/welcomeSection.dart';
import 'package:guru_bono/presentation/widgets/screenBase.dart';
import 'package:guru_bono/presentation/widgets/sideBar/navigationBloc.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget with NavigationStates {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenBase(
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          const SizedBox(height: 30.0),
          welcomeSection(),
        ],
      ),
    );
  }
}
