import 'package:guru_bono/core/framework/colors.dart';
import 'package:guru_bono/core/framework/globals.dart';
import 'package:guru_bono/data/models/bono.dart';
import 'package:guru_bono/presentation/widgets/imgsContainers/circlularimg.dart';
import 'package:flutter/material.dart';
import 'package:guru_bono/presentation/widgets/texts/screentitle.dart';

class BonoResultados extends StatelessWidget {
  BonoResultados({Key key, this.bonoResultado, this.bono}) : super(key: key);
  ResultadoBono bonoResultado;
  Bono bono;
  final TextStyle _txtStyle = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
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
            centerTitle: true,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: greenPrimary,
                size: 30,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )),
        body: _body(context));
  }

  Widget _body(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        personalData(),
        const ScreenTitle(title: 'Resultados'),
        estructuracion(),
        const SizedBox(height: 20.0),
        precioUtilidad(),
        const SizedBox(height: 20.0),
        ratiosDecision(),
        const SizedBox(height: 20.0),
        indicadoresRenta(),
        const SizedBox(height: 20.0),
      ],
    );
  }

  Widget valData(String value) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20, bottom: 5, top: 5),
          height: 20,
          width: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: greenPrimary,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          value,
          style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              decoration: TextDecoration.none),
        ),
      ],
    );
  }

  toPercentage(double num) {
    return (num * 100).toStringAsFixed(3) + '%';
  }

  Widget estructuracion() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          titleBox('Estructuración del bono'),
          valData("Frecuencia del cupón: ${bonoResultado.frecCupon}"),
          valData("Días capitalización: ${bonoResultado.diasCapita}"),
          valData("N° Periodos por año: ${bonoResultado.nPeriodosxAno}"),
          valData("N° Total de periodos: ${bonoResultado.nTotalPeriodos}"),
          valData("Tasa efectiva anual: ${toPercentage(bonoResultado.tea)}"),
          valData(
              "Tasa efectiva semestral: ${toPercentage(bonoResultado.tes)}"),
          valData("COK Semestral: ${toPercentage(bonoResultado.cokSemestral)}"),
          valData(
              "Costes iniciales emisor: ${bonoResultado.costiniEmi.toStringAsFixed(2)}"),
          valData(
              "Costes iniciales bonista: ${bonoResultado.costiniBon.toStringAsFixed(2)}"),
        ]));
  }

  Widget precioUtilidad() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          titleBox('Precio actual y utilidad'),
          valData(
              "Precio actual: ${bonoResultado.precActual.toStringAsFixed(2) ?? '-'}"),
          valData(
              "Utilidad / Pérdida: ${bonoResultado.utilidadPerdida.toStringAsFixed(2) ?? '-'}"),
        ]));
  }

  Widget ratiosDecision() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          titleBox('Ratios de decisión'),
          valData("Duración: ${bonoResultado.duracion.toStringAsFixed(2)}"),
          valData("Convexidad: ${bonoResultado.convexidad.toStringAsFixed(2)}"),
          valData("Total: ${bonoResultado.total.toStringAsFixed(2)}"),
          valData(
              "Duración modificada: ${bonoResultado.duracionMod.toStringAsFixed(2)}"),
        ]));
  }

  Widget indicadoresRenta() {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          titleBox('Indicadores de rentabilidad'),
          valData("TCEA Emisor: ?% - ?% "),
          valData("TCEA Emisor c/Escudo: ?% - ?% "),
          valData("TREA Bonista: ?% - ?% "),
        ]));
  }

  Widget personalData() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircularImg(
            pathImg: 'assets/imgs/bono_icon.png',
            vHeight: 80,
            vWidth: 80,
          ),
          const SizedBox(
            width: 40,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(bono.nombre,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 17,
                      fontWeight: FontWeight.w700)),
              SizedBox(
                width: 250,
                child: Text(
                  'id: ${bono.id}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              const Text('RUC: ' + '2054654632'),
            ],
          ),
        ],
      ),
    );
  }

  Widget titleBox(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10),
      width: double.infinity,
      decoration: const BoxDecoration(
        color: yellowPrimary,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Text(title,
          style: const TextStyle(
              fontFamily: 'Poppins-Regular',
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600)),
    );
  }
}
