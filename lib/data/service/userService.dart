import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guru_bono/data/models/user.dart';
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
            direccion: snp['direccion']));
  }
}
