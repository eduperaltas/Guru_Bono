import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guru_bono/data/models/bono.dart';
import 'package:guru_bono/data/service/metodoAleman.dart';
import 'package:guru_bono/data/service/metodoAmericano.dart';
import 'package:guru_bono/data/service/metodoFrances.dart';
import 'package:guru_bono/data/service/userService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class bonoService {
  final String BONOS = "bonos";

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createBono(Bono bono) async {
    if (bono.user == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bono.user = prefs.getString('user') ?? "";
    }
    var id = const Uuid().v1();
    _db.collection(BONOS).doc(id).set(bono.toJson());
    createResultBono(bono, id);
  }

  Future<void> updateBono(Bono bono) async {
    if (bono.user == null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bono.user = prefs.getString('user') ?? "";
    }
    _db.collection(BONOS).doc(bono.id).update(bono.toJson());
    createResultBono(bono, bono.id ?? "");
  }

  Future<List<Bono>> getBonos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('user') ?? "";

    return _db.collection(BONOS).where('user', isEqualTo: user).get().then(
        (QuerySnapshot snp) => snp.docs
            .map((DocumentSnapshot doc) => Bono(
                id: doc.id,
                nombre: doc['nombre'],
                metCalculo: doc['metCalculo'],
                moneda: doc['moneda'],
                cantidad: doc['cantidad'],
                precMercado: doc['precMercado'],
                valNominal: doc['valNominal'],
                valComercial: doc['valComercial'],
                NdeAnos: doc['NdeAnos'],
                frecCupon: doc['frecCupon'],
                diasXAno: doc['diasXAno'],
                tipTasaInteres: doc['tipTasaInteres'],
                capitalizacion: doc['capitalizacion'],
                tasaInteres: doc['tasaInteres'],
                fecEmision: doc['fecEmision'],
                impuestoRenta: doc['impuestoRenta'],
                tasaAnualDscto: doc['tasaAnualDscto'],
                prima: doc['prima'],
                estructuracion: doc['estructuracion'],
                colocacion: doc['colocacion'],
                flotacion: doc['flotacion'],
                cavali: doc['cavali']))
            .toList());
  }

  //RESULTADO
  Future<void> createResultBono(Bono bono, String id) async {
    print('Creando resultado bono...');
    print("bonoID -> ${bono.id}");

    int frecCupon = metAmericano(bono: bono).frecCupon();
    int diasCapita = metAmericano(bono: bono).diasCapit();
    int nPeriodosAno = metAmericano(bono: bono).nPeriodoxAno(frecCupon);
    int nTotalPeriodos = metAmericano(bono: bono).totalPeriodos(nPeriodosAno);
    double tea = metAmericano(bono: bono).tasaEfectivaAnual(diasCapita);
    double tes = metAmericano(bono: bono).tasaEfectivaSemestral(tea, frecCupon);
    double cokSem = metAmericano(bono: bono).COKsemestral(frecCupon);

    double costIniEmi = metAmericano(bono: bono).costIniEmisor();
    double costIniBon = metAmericano(bono: bono).costIniBonista();

    ResultadoBono res = ResultadoBono(
      frecCupon: frecCupon,
      diasCapita: diasCapita,
      nPeriodosxAno: nPeriodosAno,
      nTotalPeriodos: nTotalPeriodos,
      tea: tea,
      tes: tes,
      cokSemestral: cokSem,
      costiniEmi: costIniEmi,
      costiniBon: costIniBon,
      precActual: 0.00,
      utilidadPerdida: 0.00,
      duracion: 0.00,
      convexidad: 0.00,
      total: 0.00,
      duracionMod: 0.00,
      tceaEmi: 0.00,
      tceaEmiEscudo: 0.00,
      treaBonista: 0.00,
    );

    _db
        .collection(BONOS)
        .doc(id)
        .collection('resultado')
        .doc('data')
        .set(res.toJson());

    createCalendar(bono, res, id);
    userService().uptUserBalance();
  }

  Future<ResultadoBono> getResultadoBono(String bonoName) {
    return _db
        .collection(BONOS)
        .doc(bonoName)
        .collection('resultado')
        .doc('data')
        .get()
        .then((snp) => ResultadoBono(
              frecCupon: snp['frecCupon'],
              diasCapita: snp['diasCapita'],
              nPeriodosxAno: snp['nPeriodosxAno'],
              nTotalPeriodos: snp['nTotalPeriodos'],
              tea: snp['tea'],
              tes: snp['tes'],
              cokSemestral: snp['cokSemestral'],
              costiniEmi: snp['costiniEmi'],
              costiniBon: snp['costiniBon'],
              precActual: snp['precActual'],
              utilidadPerdida: snp['utilidadPerdida'],
              duracion: snp['duracion'],
              convexidad: snp['convexidad'],
              total: snp['total'],
              duracionMod: snp['duracionMod'],
              tceaEmi: snp['tceaEmi'],
              tceaEmiEscudo: snp['tceaEmiEscudo'],
              treaBonista: snp['treaBonista'],
            ));
  }

  //Calendar
  Future<void> createCalendar(Bono bono, ResultadoBono res, String id) async {
    print('Creando calendario bono...');
    List<CalendarioPagos> lstCalendar = bono.metCalculo == "Americano"
        ? metAmericano(bono: bono).generateCalendar(res)
        : bono.metCalculo == "Frances"
            ? metFrances(bono: bono).generateCalendar(res)
            : metAleman(bono: bono).generateCalendar(res);
    lstCalendar.forEach((element) {
      _db
          .collection(BONOS)
          .doc(id)
          .collection('calendario')
          .doc(element.fechaProg)
          .set(element.ToJson());
    });

    //UPTADE RESULTADO
    double duracion = metAmericano(bono: bono).duracion(lstCalendar);
    double convexidad = metAmericano(bono: bono)
        .convexidad(lstCalendar, res.cokSemestral, res.frecCupon);
    double total = duracion + convexidad;
    double duracionMod =
        metAmericano(bono: bono).duracionModificada(duracion, res.cokSemestral);

    double precActual =
        metAmericano(bono: bono).precioActual(lstCalendar, res.cokSemestral);
    double utilidadPerdida =
        metAmericano(bono: bono).utilidadPerdida(lstCalendar, res.cokSemestral);
    double tceaEmisor =
        metAmericano(bono: bono).tceaEmisor(lstCalendar, res.frecCupon);
    double tceaEmisorEscudo =
        metAmericano(bono: bono).tceaEmisorEscudo(lstCalendar, res.frecCupon);
    double tceaBonista =
        metAmericano(bono: bono).tceaBonista(lstCalendar, res.frecCupon);

    ResultadoBono resUPT = ResultadoBono(
      frecCupon: res.frecCupon,
      diasCapita: res.diasCapita,
      nPeriodosxAno: res.nPeriodosxAno,
      nTotalPeriodos: res.nTotalPeriodos,
      tea: res.tea,
      tes: res.tes,
      cokSemestral: res.cokSemestral,
      costiniEmi: res.costiniEmi,
      costiniBon: res.costiniBon,
      precActual: precActual,
      utilidadPerdida: utilidadPerdida,
      duracion: duracion,
      convexidad: convexidad,
      total: total,
      duracionMod: duracionMod,
      tceaEmi: tceaEmisor,
      tceaEmiEscudo: tceaEmisorEscudo,
      treaBonista: tceaBonista,
    );
    _db
        .collection(BONOS)
        .doc(id)
        .collection('resultado')
        .doc('data')
        .update(resUPT.toJson());
  }

  Future<List<CalendarioPagos>> getCalendar(String id) async {
    return _db.collection(BONOS).doc(id).collection('calendario').get().then(
        (QuerySnapshot snp) => snp.docs
            .map((DocumentSnapshot doc) => CalendarioPagos(
                fechaProg: doc['fechaProg'],
                infAnual: doc['infAnual'],
                infSemestral: doc['infSemestral'],
                plazoGracia: doc['plazoGracia'],
                Bono: doc['Bono'],
                BonoIndexado: doc['BonoIndexado'],
                cupon: doc['cupon'],
                cuota: doc['cuota'],
                amort: doc['amort'],
                prima: doc['prima'],
                escudo: doc['escudo'],
                flujoEmi: doc['flujoEmi'],
                flujoEmiEsc: doc['flujoEmiEsc'],
                flujoBon: doc['flujoBon'],
                flujoAct: doc['flujoAct'],
                faXPlazo: doc['faXPlazo'],
                factorConvex: doc['factorConvex']))
            .toList());
  }
}
