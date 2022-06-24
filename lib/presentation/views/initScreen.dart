import 'package:guru_bono/presentation/widgets/sideBar/navigationBloc.dart';
import 'package:guru_bono/presentation/widgets/sideBar/sidebarLayout.dart';
import 'package:flutter/material.dart';

class InitScreen extends StatelessWidget with NavigationStates {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SideBarLayout(),
    );
  }
}
