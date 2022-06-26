import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guru_bono/data/models/bono.dart';
import 'package:guru_bono/data/models/user.dart';
import 'package:guru_bono/data/service/bonoService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userService {
  final String USERS = "users";

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<User> getUser(String user) async {
    //sp si no hay user
    if (user == "") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(prefs.getString('user'));
      user = prefs.getString('user') ?? "";
    }

    Future.delayed(const Duration(seconds: 1));
    return _db.collection(USERS).doc(user).get().then((DocumentSnapshot snp) =>
        User(
            id: user,
            user: user,
            name: snp['nombre'],
            password: snp['password'],
            dni: snp['dni'],
            direccion: snp['direccion'],
            penCustVal: double.parse(snp['custValPen']),
            usdCustVal: double.parse(snp['custValUsd']),
            penEfectivo: double.parse(snp['efectivoPen']),
            usdEfectivo: double.parse(snp['efectivoUsd'])));
  }

  Future<void> uptUserBalance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user = prefs.getString('user') ?? "";
    double sumCustValUsd = 0;
    double sumCustValPen = 0;
    List<Bono> lstBonos = await bonoService().getBonos();

    lstBonos.forEach((bono) {
      sumCustValUsd +=
          bono.moneda == "USD" ? (bono.cantidad * bono.precMercado) : 0;
      sumCustValPen +=
          bono.moneda == "PEN" ? (bono.cantidad * bono.precMercado) : 0;
    });
    _db.collection(USERS).doc(user).update({
      'custValPen': sumCustValPen.toStringAsFixed(2),
      'custValUsd': sumCustValUsd.toStringAsFixed(2),
    });
  }
}
