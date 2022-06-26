import 'package:guru_bono/core/framework/colors.dart';
import 'package:guru_bono/core/framework/globals.dart';
import 'package:flutter/material.dart';
import 'package:guru_bono/data/models/user.dart';
import 'package:guru_bono/data/service/userService.dart';
import 'package:guru_bono/presentation/widgets/texts/screentitle.dart';
import 'package:pie_chart/pie_chart.dart';

class welcomeSection extends StatefulWidget {
  welcomeSection({Key key}) : super(key: key);

  @override
  State<welcomeSection> createState() => _welcomeSectionState();
}

class _welcomeSectionState extends State<welcomeSection> {
  Map<String, double> dataMap = {
    "USD": 0,
    "PEN": 0,
  };

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder(
      future: userService().getUser(""),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
              child: CircularProgressIndicator(
            color: greenPrimary,
          ));
        } else {
          User usuario = snapshot.data as User;
          dataMap["USD"] = usuario.usdEfectivo + usuario.usdCustVal;
          dataMap["PEN"] = usuario.penEfectivo + usuario.penCustVal;
          return ListView(
            children: [
              // WELCOME-SECTION
              welcome(context, usuario.name, usuario.dni, usuario.direccion),
              valorizacion(context),
              const SizedBox(height: 10.0),
              stats(greenPrimary.withOpacity(0.7), "USD", usuario.usdEfectivo,
                  usuario.usdCustVal, context),
              const SizedBox(height: 10.0),
              stats(greenSoft.withOpacity(0.7), "PEN", usuario.penEfectivo,
                  usuario.penCustVal, context),
              const SizedBox(height: 10.0),
            ],
          );
        }
      },
    ));
  }

  //PIE-CHART
  Widget valorizacion(BuildContext context) {
    return Column(
      children: [
        const ScreenTitle(title: 'Valorización'),
        PieChart(
            colorList: [
              greenPrimary.withOpacity(0.7),
              greenSoft.withOpacity(0.7),
            ],
            dataMap: dataMap,
            chartValuesOptions: const ChartValuesOptions(
              showChartValuesInPercentage: true,
            ),
            chartRadius: MediaQuery.of(context).size.width * 0.4),
      ],
    );
  }

// WELCOME-WIDGETS
  Widget welcome(
      BuildContext context, String userName, String dni, String direccion) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: ScreenWH(context).width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bienvenido " + userName,
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: txtPrimary,
                decoration: TextDecoration.none),
          ),
          Text(
            "DNI: $dni",
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: txtgrey,
                decoration: TextDecoration.none),
          ),
          Text(
            "Dirección: $direccion",
            style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: txtgrey,
                decoration: TextDecoration.none),
          ),
        ],
      ),
    );
  }

  Widget stats(Color colorbkground, String title, double efectivo,
      double custVal, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
      width: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorbkground,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      decoration: TextDecoration.none)),
              Text("Total: ${(custVal + efectivo).toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      decoration: TextDecoration.none)),
            ],
          ),
          const SizedBox(height: 5),
          valorizacionData("Custodio Valores: ${custVal.toStringAsFixed(2)}"),
          const SizedBox(height: 5),
          valorizacionData("Efectivo: ${efectivo.toStringAsFixed(2)}"),
        ],
      ),
    );
  }

  Widget valorizacionData(String value) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10, bottom: 5),
          height: 20,
          width: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
              decoration: TextDecoration.none),
        ),
      ],
    );
  }
}
