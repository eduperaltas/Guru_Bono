import 'package:guru_bono/core/framework/colors.dart';
import 'package:guru_bono/core/framework/globals.dart';
import 'package:guru_bono/data/models/user.dart';
import 'package:guru_bono/data/service/userService.dart';
import 'package:guru_bono/presentation/views/initScreen.dart';
import 'package:guru_bono/presentation/widgets/buttons/buttonLarge.dart';
import 'package:guru_bono/presentation/widgets/forms/textForm.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dniController = TextEditingController();
  final TextEditingController _direcController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  register(String user, String password, String name, String dni,
      String direccion, BuildContext context) async {
    await userService().createUser(User(
        user: user,
        name: name,
        password: password,
        dni: dni,
        direccion: direccion));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InitScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // String password = '';
    txtForm _txtFormemail = txtForm(
      title: 'Usuario',
      controller: _emailController,
      inputType: InputType.Email,
    );
    txtForm _txtFormpasssword = txtForm(
      title: 'Contraseña',
      controller: _passwordController,
      inputType: InputType.Password,
    );
    txtForm _txtFormNombre = txtForm(
      title: 'Nombre',
      controller: _nameController,
      inputType: InputType.Default,
    );
    txtForm _txtFormDni = txtForm(
      title: 'DNI',
      controller: _dniController,
      inputType: InputType.Default,
    );
    txtForm _txtFormDirec = txtForm(
      title: 'Direccion',
      controller: _direcController,
      inputType: InputType.Default,
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
                "Registrate",
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
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: _txtFormNombre),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: _txtFormDni),
            Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: _txtFormDirec),
            ButtonLarge(
                text: 'Registrarse',
                onPressed: () {
                  register(
                      _emailController.text,
                      _passwordController.text,
                      _nameController.text,
                      _dniController.text,
                      _direcController.text,
                      context);
                }),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: ScreenWH(context).width * 0.8,
                child: const Text('Atras',
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
