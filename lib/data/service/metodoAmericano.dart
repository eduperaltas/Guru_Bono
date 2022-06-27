import 'dart:math';
import 'package:finance/finance.dart';
import 'package:intl/intl.dart';
import 'package:guru_bono/data/models/bono.dart';

class metAmericano {
  final Bono bono;
  metAmericano({this.bono});

  frecCupon() {
    switch (bono.frecCupon) {
      case "Mensual":
        return 30;
      case "Bimestral":
        return 60;

      case "Trimestral":
        return 90;

      case "Cuatrimestral":
        return 120;

      case "Semestral":
        return 180;

      case "Anual":
        return 360;
    }
  }

  diasCapit() {
    switch (bono.capitalizacion) {
      case "Diaria":
        return 1;

      case "Quincenal":
        return 15;

      case "Mensual":
        return 30;

      case "Bimestral":
        return 60;

      case "Trimestral":
        return 90;

      case "Cuatrimestral":
        return 120;

      case "Semestral":
        return 180;

      case "Anual":
        return 360;
    }
  }

  nPeriodoxAno(int frecCupon) {
    return int.parse(bono.diasXAno) ~/ frecCupon;
  }

  totalPeriodos(int nPeriodos) {
    return nPeriodos * bono.NdeAnos;
  }

  tasaEfectivaAnual(int diasCapit) {
    if (bono.tipTasaInteres == "Efectiva") {
      return bono.tasaInteres;
    } else {
      return pow(
              (1 + bono.tasaInteres / (int.parse(bono.diasXAno) / diasCapit)),
              (int.parse(bono.diasXAno) / diasCapit)) -
          1;
    }
  }

  tasaEfectivaSemestral(double tea, int frecCupon) {
    return pow(1 + tea, frecCupon / int.parse(bono.diasXAno)) - 1;
  }

  COKsemestral(int frecCupon) {
    return pow(1 + bono.tasaAnualDscto, frecCupon / int.parse(bono.diasXAno)) -
        1;
  }

  costIniEmisor() {
    dynamic estructurazion = bono.estructuracion.split('-');
    dynamic colocacion = bono.colocacion.split('-');
    dynamic flotacion = bono.flotacion.split('-');
    dynamic cavali = bono.cavali.split('-');

    estructurazion =
        estructurazion[1] != "Bonista" ? double.parse(estructurazion[0]) : 0;
    colocacion = colocacion[1] != "Bonista" ? double.parse(colocacion[0]) : 0;
    flotacion = flotacion[1] != "Bonista" ? double.parse(flotacion[0]) : 0;
    cavali = cavali[1] != "Bonista" ? double.parse(cavali[0]) : 0;

    return (estructurazion + colocacion + flotacion + cavali) *
        bono.valComercial;
  }

  costIniBonista() {
    dynamic estructurazion = bono.estructuracion.split('-');
    dynamic colocacion = bono.colocacion.split('-');
    dynamic flotacion = bono.flotacion.split('-');
    dynamic cavali = bono.cavali.split('-');

    estructurazion =
        estructurazion[1] != "Emisor" ? double.parse(estructurazion[0]) : 0;
    colocacion = colocacion[1] != "Emisor" ? double.parse(colocacion[0]) : 0;
    flotacion = flotacion[1] != "Emisor" ? double.parse(flotacion[0]) : 0;
    cavali = cavali[1] != "Emisor" ? double.parse(cavali[0]) : 0;

    return (estructurazion + colocacion + flotacion + cavali) *
        bono.valComercial;
  }

  duracion(List<CalendarioPagos> calend) {
    double flujoAct = 0;
    double faxPlazo = 0;
    for (var element in calend) {
      print("flujoAct: ${element.fechaProg} - ${element.flujoAct}");
      print("faxPlazo: ${element.fechaProg} - ${element.faXPlazo}");
      flujoAct += element.flujoAct;
      faxPlazo += element.faXPlazo;
    }
    return faxPlazo / flujoAct;
  }

  convexidad(List<CalendarioPagos> calend, double cokSem, int frecCupon) {
    double flujoAct = 0;
    double facConvex = 0;
    calend.forEach((element) {
      flujoAct += element.flujoAct;
      facConvex += element.factorConvex;
    });

    return facConvex /
        (pow(1 + cokSem, 2) *
            flujoAct *
            pow(int.parse(bono.diasXAno) / frecCupon, 2));
  }

  duracionModificada(double duracion, double cokSem) {
    return duracion / (1 + cokSem);
  }

  precioActual(List<CalendarioPagos> calend, double cokSem) {
    List<double> nums = [];
    for (int i = 1; i < calend.length; i++) {
      nums.add(calend[i].flujoBon);
    }
    return Finance.npv(rate: cokSem, values: nums).toDouble();
  }

  utilidadPerdida(List<CalendarioPagos> calend, double cokSem) {
    List<double> nums = [];
    for (int i = 1; i < calend.length; i++) {
      nums.add(calend[i].flujoBon);
    }
    print(
        'first: ${calend[0].flujoBon} - ${Finance.npv(rate: cokSem, values: nums)}');
    return calend[0].flujoBon +
        Finance.npv(rate: cokSem, values: nums).toDouble();
  }

  tceaEmisor(List<CalendarioPagos> calend, int frecCupon) {
    List<double> nums = [];
    for (int i = 0; i < calend.length; i++) {
      nums.add(calend[i].flujoEmi);
    }
    return pow(Finance.irr(values: nums) + 1,
            int.parse(bono.diasXAno) / frecCupon) -
        1;
  }

  tceaEmisorEscudo(List<CalendarioPagos> calend, int frecCupon) {
    List<double> nums = [];
    for (int i = 0; i < calend.length; i++) {
      nums.add(calend[i].flujoEmiEsc);
    }
    return pow(Finance.irr(values: nums) + 1,
            int.parse(bono.diasXAno) / frecCupon) -
        1;
  }

  tceaBonista(List<CalendarioPagos> calend, int frecCupon) {
    List<double> nums = [];
    for (int i = 0; i < calend.length; i++) {
      nums.add(calend[i].flujoBon);
    }
    return pow(Finance.irr(values: nums) + 1,
            int.parse(bono.diasXAno) / frecCupon) -
        1;
  }

  List<CalendarioPagos> generateCalendar(ResultadoBono res) {
    List<CalendarioPagos> calendario = [];

    for (int i = 0; i <= res.nTotalPeriodos; i++) {
      if (i == 0) {
        CalendarioPagos cal = CalendarioPagos(
            fechaProg: DateFormat('dd-MM-yyyy')
                .format(DateFormat('d/M/y')
                    .parse(bono.fecEmision)
                    .add(Duration(days: i * res.frecCupon)))
                .toString(),
            infAnual: 0.00,
            infSemestral: 0.00,
            plazoGracia: '',
            Bono: 0.00,
            BonoIndexado: 0.00,
            cupon: 0.00,
            cuota: 0.00,
            amort: 0.00,
            prima: 0.00,
            escudo: 0.00,
            flujoEmi: res.costiniEmi + bono.valComercial,
            flujoEmiEsc: res.costiniEmi + bono.valComercial,
            flujoBon: -bono.valComercial - res.costiniBon,
            flujoAct: 0.00,
            faXPlazo: 0.00,
            factorConvex: 0.00);
        calendario.add(cal);
      } else {
        CalendarioPagos anterior = calendario[i - 1];
        String fecprogramada = DateFormat('dd-MM-yyyy')
            .format(DateFormat('d/M/y')
                .parse(bono.fecEmision)
                .add(Duration(days: i * res.frecCupon)))
            .toString();
        double infAnual = 0.0;
        double infSemestral = i <= res.nTotalPeriodos
            ? pow(1 + infAnual, res.frecCupon / int.parse(bono.diasXAno)) - 1
            : 0;
        String plazoGracia = 'S';
        double cbono = i == 1
            ? bono.valNominal
            : i <= res.nTotalPeriodos
                ? plazoGracia == 'T'
                    ? anterior.BonoIndexado - anterior.cupon
                    : anterior.BonoIndexado + anterior.amort
                : 0.00;
        double bonoIndex = cbono * (1 + infSemestral);
        double cupon = -bonoIndex * res.tes;
        double amort = i <= res.nTotalPeriodos
            ? i <= res.nTotalPeriodos - 1
                ? 0
                : -bonoIndex
            : 0;
        double cuota = i <= res.nTotalPeriodos
            ? plazoGracia == 'T'
                ? 0
                : (cupon + amort)
            : 0;
        double prima =
            -(i == res.nTotalPeriodos ? bono.prima * bono.valNominal : 0.00);
        double escudo = -cupon * bono.impuestoRenta;
        double flujEmi = i <= res.nTotalPeriodos ? cuota + prima : 0;
        double flujEmiEscu = escudo + flujEmi;
        double flujBonista = -flujEmi;
        double flujAct = flujBonista / pow(1 + res.cokSemestral, i);
        double faxPlazo =
            flujAct * i * res.frecCupon / int.parse(bono.diasXAno);
        double factConvex = flujAct * i * (1 + i);

        CalendarioPagos cal = CalendarioPagos(
            fechaProg: fecprogramada,
            infAnual: infAnual,
            infSemestral: infSemestral,
            plazoGracia: plazoGracia,
            Bono: cbono,
            BonoIndexado: bonoIndex,
            cupon: cupon,
            cuota: cuota,
            amort: amort,
            prima: prima,
            escudo: escudo,
            flujoEmi: flujEmi,
            flujoEmiEsc: flujEmiEscu,
            flujoBon: flujBonista,
            flujoAct: flujAct,
            faXPlazo: faxPlazo,
            factorConvex: factConvex);
        calendario.add(cal);
      }
    }

    return calendario;
  }
}
