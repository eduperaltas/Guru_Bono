import 'dart:async';

import 'package:guru_bono/core/framework/colors.dart';
import 'package:guru_bono/core/framework/globals.dart';
import 'package:guru_bono/presentation/views/login.dart';
import 'package:guru_bono/presentation/widgets/imgsContainers/circlularimg.dart';
import 'package:guru_bono/presentation/widgets/sideBar/menuItem.dart';
import 'package:guru_bono/presentation/widgets/sideBar/navigationBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rxdart/rxdart.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 400);

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return StreamBuilder<bool>(
      initialData: false,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left:
              isSideBarOpenedAsync.data.toString() == 'true' ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data.toString() == 'true'
              ? 0
              : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: background1,
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset('assets/imgs/guru_logo.png',
                          height: ScreenWH(context).height * 0.18,
                          width: ScreenWH(context).width * 0.55),
                    ),
                    Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        height: ScreenWH(context).height * 0.1,
                        width: ScreenWH(context).width * 0.8,
                        decoration: const BoxDecoration(
                            color: greenSoft,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Row(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child:
                                  CircularImg(pathImg: 'assets/imgs/male.png'),
                            ),
                            const Text(
                              'Eduardo Perez',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        )),
                    MenuItemWidget(
                      icon: Icons.home,
                      title: "Inicio",
                      onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.homeScreenClickedEvent);
                      },
                    ),
                    dividerLine(),
                    MenuItemWidget(
                      icon: Icons.request_quote,
                      title: "Bonos",
                      onTap: () {
                        onIconPressed();
                        BlocProvider.of<NavigationBloc>(context)
                            .add(NavigationEvents.pedidosScreenClickedEvent);
                      },
                    ),
                    // dividerLine(),
                    // MenuItemWidget(
                    //   icon: Icons.settings,
                    //   title: "Configuración",
                    //   onTap: () {
                    //     onIconPressed();
                    //     BlocProvider.of<NavigationBloc>(context)
                    //         .add(NavigationEvents.pedidosScreenClickedEvent);
                    //   },
                    // ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          MenuItemWidget(
                            icon: Icons.exit_to_app,
                            title: "Logout",
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            },
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            margin: const EdgeInsets.only(bottom: 20),
                            child: const Text('Versión 1.0'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
              Align(
                alignment: const Alignment(0, -0.99),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 45,
                      height: 110,
                      color: background1,
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.menu_close,
                        color: greenPrimary,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget dividerLine() {
    return const Divider(
      height: 10,
      thickness: 2.5,
      color: greenSoft,
      indent: 0,
      endIndent: 180,
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
