import 'dart:ui';

import 'package:guru_bono/core/framework/colors.dart';
import 'package:guru_bono/core/framework/globals.dart';
import 'package:guru_bono/data/models/bono.dart';
import 'package:guru_bono/presentation/widgets/imgsContainers/circlularimg.dart';
import 'package:flutter/material.dart';
import 'package:guru_bono/presentation/widgets/texts/screentitle.dart';

class BonoCalendario extends StatefulWidget {
  BonoCalendario({Key key, this.calPagos, this.bono}) : super(key: key);
  List<CalendarioPagos> calPagos;
  Bono bono;

  @override
  State<BonoCalendario> createState() => _BonoCalendarioState();
}

class _BonoCalendarioState extends State<BonoCalendario> {
  final TextStyle _txtStyle = const TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15,
    fontWeight: FontWeight.w500,
  );
  List<bool> isExpanded = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

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
        const ScreenTitle(title: 'Cronograma de pagos'),
        lstCalendar(widget.calPagos)
      ],
    );
  }

  toPercentage(double num) {
    return (num * 100).toStringAsFixed(3) + '%';
  }

  Widget valData(String value) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 40, bottom: 5, top: 5),
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

  Widget bonoPago(BuildContext context, CalendarioPagos calBono, int index) {
    return Theme(
      data: ThemeData().copyWith(dividerColor: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: ExpansionTile(
          collapsedTextColor: greenPrimary,
          textColor: greenPrimary,
          onExpansionChanged: (bool value) {
            setState(() {
              isExpanded[index] = value;
            });
          },
          childrenPadding: const EdgeInsets.only(right: 15),
          trailing: Icon(
            isExpanded[index]
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_right_rounded,
            color: greenPrimary,
            size: 35,
          ),
          title: Text(
            calBono.fechaProg,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          children: <Widget>[
            valData('Inflación anual: ${calBono.infAnual.toStringAsFixed(2)}'),
            valData(
                'Inflación Semestral: ${calBono.infSemestral.toStringAsFixed(2)}'),
            valData('Plazo de Gracia: ${calBono.plazoGracia}'),
            valData('Bono: ${calBono.Bono.toStringAsFixed(2)}'),
            valData(
                'Bono Indexado: ${calBono.BonoIndexado.toStringAsFixed(2)}'),
            valData('Cupon (interes): ${calBono.cupon.toStringAsFixed(2)}'),
            valData('Cuota: ${calBono.cuota.toStringAsFixed(2)}'),
            valData('Amort: ${calBono.amort.toStringAsFixed(2)}'),
            valData('Prima: ${calBono.prima.toStringAsFixed(2)}'),
            valData('Escudo: ${calBono.escudo.toStringAsFixed(2)}'),
            valData('Flujo emisor: ${calBono.flujoEmi.toStringAsFixed(2)}'),
            valData(
                'Flujo emisor c/Escudo: ${calBono.flujoEmiEsc.toStringAsFixed(2)}'),
            valData('Flujo bonista: ${calBono.flujoBon.toStringAsFixed(2)}'),
            valData('Flujo Act.: ${calBono.flujoAct.toStringAsFixed(2)}'),
            valData('FA x Plazo: ${calBono.faXPlazo.toStringAsFixed(2)}'),
            valData(
                'Factor p/Convexidad: ${calBono.factorConvex.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }

  Widget lstCalendar(List<CalendarioPagos> lst) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: lst.length,
      itemBuilder: (BuildContext context, int index) {
        return bonoPago(context, lst[index], index);
      },
    );
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
              Text(widget.bono.nombre,
                  style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 17,
                      fontWeight: FontWeight.w700)),
              SizedBox(
                width: 250,
                child: Text(
                  'id: ${widget.bono.id}',
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
