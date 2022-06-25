import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guru_bono/data/models/bono.dart';
import 'package:guru_bono/data/service/metodoFrances.dart';
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

  void updateBono(Bono bono) {
    _db.collection(BONOS).doc(bono.id).update(bono.toJson());
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
    int frecCupon =
        bono.metCalculo == "Frances" ? metFrances(bono: bono).frecCupon() : 0;
    int diasCapita =
        bono.metCalculo == "Frances" ? metFrances(bono: bono).diasCapit() : 0;
    int nPeriodosAno = bono.metCalculo == "Frances"
        ? metFrances(bono: bono).nPeriodoxAno(frecCupon)
        : 0;
    int nTotalPeriodos = bono.metCalculo == "Frances"
        ? metFrances(bono: bono).totalPeriodos(nPeriodosAno)
        : 0;
    double tea = bono.metCalculo == "Frances"
        ? metFrances(bono: bono).tasaEfectivaAnual(diasCapita)
        : 0.00;
    double tes = bono.metCalculo == "Frances"
        ? metFrances(bono: bono).tasaEfectivaSemestral(tea, frecCupon)
        : 0.00;
    double cokSem = bono.metCalculo == "Frances"
        ? metFrances(bono: bono).COKsemestral(frecCupon)
        : 0.00;

    double costIniEmi = bono.metCalculo == "Frances"
        ? metFrances(bono: bono).costIniEmisor()
        : 0.00;
    double costIniBon = bono.metCalculo == "Frances"
        ? metFrances(bono: bono).costIniBonista()
        : 0.00;

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
    List<CalendarioPagos> lstCalendar =
        metFrances(bono: bono).generateCalendar(res);
    lstCalendar.forEach((element) {
      _db
          .collection(BONOS)
          .doc(id)
          .collection('calendario')
          .doc(element.fechaProg)
          .set(element.ToJson());
    });

    //UPTADE RESULTADO
    double duracion = metFrances(bono: bono).duracion(lstCalendar);
    double convexidad = metFrances(bono: bono)
        .convexidad(lstCalendar, res.cokSemestral, res.frecCupon);
    double total = duracion + convexidad;
    double duracionMod =
        metFrances(bono: bono).duracionModificada(duracion, res.cokSemestral);

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
      precActual: res.precActual,
      utilidadPerdida: res.utilidadPerdida,
      duracion: duracion,
      convexidad: convexidad,
      total: total,
      duracionMod: duracionMod,
      tceaEmi: res.tceaEmi,
      tceaEmiEscudo: res.tceaEmiEscudo,
      treaBonista: res.treaBonista,
    );
    _db
        .collection(BONOS)
        .doc(id)
        .collection('resultado')
        .doc('data')
        .update(resUPT.toJson());
  }
}
