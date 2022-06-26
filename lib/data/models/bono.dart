class Bono {
  String id;
  String user;
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
      this.nombre,
      this.metCalculo,
      this.moneda,
      this.cantidad,
      this.precMercado,
      this.valNominal,
      this.valComercial,
      this.NdeAnos,
      this.frecCupon,
      this.diasXAno,
      this.tipTasaInteres,
      this.capitalizacion,
      this.tasaInteres,
      this.fecEmision,
      this.impuestoRenta,
      this.tasaAnualDscto,
      this.prima,
      this.estructuracion,
      this.colocacion,
      this.flotacion,
      this.cavali});

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
    this.frecCupon,
    this.diasCapita,
    this.nPeriodosxAno,
    this.nTotalPeriodos,
    this.tea,
    this.tes,
    this.cokSemestral,
    this.costiniEmi,
    this.costiniBon,
    this.precActual,
    this.utilidadPerdida,
    this.duracion,
    this.convexidad,
    this.total,
    this.duracionMod,
    this.tceaEmi,
    this.tceaEmiEscudo,
    this.treaBonista,
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
    this.fechaProg,
    this.infAnual,
    this.infSemestral,
    this.plazoGracia,
    this.Bono,
    this.BonoIndexado,
    this.cupon,
    this.cuota,
    this.amort,
    this.prima,
    this.escudo,
    this.flujoEmi,
    this.flujoEmiEsc,
    this.flujoBon,
    this.flujoAct,
    this.faXPlazo,
    this.factorConvex,
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
