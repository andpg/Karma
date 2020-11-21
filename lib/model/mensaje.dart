import 'package:Karma/model/user.dart';

class Mensaje {
  String id;
  User user;
  String texto;
  int hora;

  Mensaje(Map json)
      : id = json["id"],
        user = User(json["user"]),
        texto = json["texto"],
        hora = json["hora"];
}
