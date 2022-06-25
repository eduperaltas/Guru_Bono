class Bono {
  String? id;
  String? user;
  final String nombre;
  final String metCalculo;
  final String moneda;
  final int cantidad;
  final double precMercado;
  final double valNominal;
  final double valComercial;
  final int NdeAnos;
  final String frecCupon;
  final String diasXAno;
  final String tipTasaInteres;
  final String capitalizacion;
  final double tasaInteres;
  final String fecEmision;
  final double impuestoRenta;
  final double tasaAnualDscto;
  final double prima;
  final String estructuracion;
  final String colocacion;
  final String flotacion;
  final String cavali;

  Bono(
      {this.id,
      this.user,
      required this.nombre,
      required this.metCalculo,
      required this.moneda,
      required this.cantidad,
      required this.precMercado,
      required this.valNominal,
      required this.valComercial,
      required this.NdeAnos,
      required this.frecCupon,
      required this.diasXAno,
      required this.tipTasaInteres,
      required this.capitalizacion,
      required this.tasaInteres,
      required this.fecEmision,
      required this.impuestoRenta,
      required this.tasaAnualDscto,
      required this.prima,
      required this.estructuracion,
      required this.colocacion,
      required this.flotacion,
      required this.cavali});

  toJson() {
    return {
      'user': user,
      'nombre': nombre,
      'metCalculo': metCalculo,
      'moneda': moneda,
      'cantidad': cantidad,
      'precMercado': precMercado,
      'valNominal': valNominal,
      'valComercial': valComercial,
      'NdeAnos': NdeAnos,
      'frecCupon': frecCupon,
      'diasXAno': diasXAno,
      'tipTasaInteres': tipTasaInteres,
      'capitalizacion': capitalizacion,
      'tasaInteres': tasaInteres,
      'fecEmision': fecEmision,
      'impuestoRenta': impuestoRenta,
      'tasaAnualDscto': tasaAnualDscto,
      'prima': prima,
      'estructuracion': estructuracion,
      'colocacion': colocacion,
      'flotacion': flotacion,
      'cavali': cavali,
    };
  }
}

class ResultadoBono {
  final int frecCupon;
  final int diasCapita;
  final int nPeriodosxAno;
  final int nTotalPeriodos;
  final double tea;
  final double tes;
  final double cokSemestral;
  final double costiniEmi;
  final double costiniBon;
  final double precActual;
  final double utilidadPerdida;
  final double duracion;
  final double convexidad;
  final double total;
  final double duracionMod;
  final double tceaEmi;
  final double tceaEmiEscudo;
  final double treaBonista;

  ResultadoBono({
    required this.frecCupon,
    required this.diasCapita,
    required this.nPeriodosxAno,
    required this.nTotalPeriodos,
    required this.tea,
    required this.tes,
    required this.cokSemestral,
    required this.costiniEmi,
    required this.costiniBon,
    required this.precActual,
    required this.utilidadPerdida,
    required this.duracion,
    required this.convexidad,
    required this.total,
    required this.duracionMod,
    required this.tceaEmi,
    required this.tceaEmiEscudo,
    required this.treaBonista,
  });

  toJson() {
    return {
      'frecCupon': frecCupon,
      'diasCapita': diasCapita,
      'nPeriodosxAno': nPeriodosxAno,
      'nTotalPeriodos': nTotalPeriodos,
      'tea': tea,
      'tes': tes,
      'cokSemestral': cokSemestral,
      'costiniEmi': costiniEmi,
      'costiniBon': costiniBon,
      'precActual': precActual,
      'utilidadPerdida': utilidadPerdida,
      'duracion': duracion,
      'convexidad': convexidad,
      'total': total,
      'duracionMod': duracionMod,
      'tceaEmi': tceaEmi,
      'tceaEmiEscudo': tceaEmiEscudo,
      'treaBonista': treaBonista,
    };
  }
}

class CalendarioPagos {
  final String fechaProg;
  final double infAnual;
  final double infSemestral;
  final String plazoGracia;
  final double Bono;
  final double BonoIndexado;
  final double cupon;
  final double cuota;
  final double amort;
  final double prima;
  final double escudo;
  final double flujoEmi;
  final double flujoEmiEsc;
  final double flujoBon;
  final double flujoAct;
  final double faXPlazo;
  final double factorConvex;

  CalendarioPagos({
    required this.fechaProg,
    required this.infAnual,
    required this.infSemestral,
    required this.plazoGracia,
    required this.Bono,
    required this.BonoIndexado,
    required this.cupon,
    required this.cuota,
    required this.amort,
    required this.prima,
    required this.escudo,
    required this.flujoEmi,
    required this.flujoEmiEsc,
    required this.flujoBon,
    required this.flujoAct,
    required this.faXPlazo,
    required this.factorConvex,
  });

  ToJson() {
    return {
      'fechaProg': fechaProg,
      'infAnual': infAnual,
      'infSemestral': infSemestral,
      'plazoGracia': plazoGracia,
      'Bono': Bono,
      'BonoIndexado': BonoIndexado,
      'cupon': cupon,
      'cuota': cuota,
      'amort': amort,
      'prima': prima,
      'escudo': escudo,
      'flujoEmi': flujoEmi,
      'flujoEmiEsc': flujoEmiEsc,
      'flujoBon': flujoBon,
      'flujoAct': flujoAct,
      'faXPlazo': faXPlazo,
      'factorConvex': factorConvex,
    };
  }
}
