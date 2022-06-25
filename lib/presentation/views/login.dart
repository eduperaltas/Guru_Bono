import 'package:guru_bono/core/framework/colors.dart';
import 'package:guru_bono/core/framework/globals.dart';
import 'package:guru_bono/data/models/user.dart';
import 'package:guru_bono/data/service/userService.dart';
import 'package:guru_bono/presentation/views/initScreen.dart';
import 'package:guru_bono/presentation/widgets/buttons/buttonLarge.dart';
import 'package:guru_bono/presentation/widgets/forms/textForm.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  login(String user, String password, BuildContext context) async {
    User us = await userService().getUser( user);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', us.user);
    print('email: ' + _emailController.text + ' password: ' + _passwordController.text);
    print("${us.name} logeado");
    if(us.password==password){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InitScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // String password = '';
    txtForm _txtFormemail = txtForm(
      title: 'Email',
      controller: _emailController,
      inputType: InputType.Email,
    );
    txtForm _txtFormpasssword = txtForm(
      title: 'Contraseña',
      controller: _passwordController,
      inputType: InputType.Password,
    );

    return Scaffold(
      backgroundColor: background1,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Image.asset('assets/imgs/guru_logo.png',
                    height: ScreenWH(context).height * 0.3,
                    width: ScreenWH(context).width * 0.7)),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(left: 30),
              child: const Text(
                "Inicia sesión",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: txtPrimary,
                    decoration: TextDecoration.none),
              ),
            ),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: _txtFormemail),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: _txtFormpasssword),
            ButtonLarge(
                text: 'Iniciar sesión',
                onPressed: () {
                  login(_emailController.text, _passwordController.text,context);
                }),
            GestureDetector(
              onTap: () {

              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: ScreenWH(context).width * 0.8,
                child: const Text('¿Olvidaste tu contraseña?',
                    style: TextStyle(
                        color: greenPrimary,
                        fontSize: 16,
                        decoration: TextDecoration.none)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
