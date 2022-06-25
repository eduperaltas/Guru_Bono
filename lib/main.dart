import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guru_bono/presentation/views/initScreen.dart';
import 'package:guru_bono/presentation/views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

late String user;
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user = prefs.getString('user')??"";
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: user!="" ? InitScreen() :Login(),
    );
  }
}
