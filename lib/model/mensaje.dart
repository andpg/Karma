import 'package:Karma/model/user.dart';

class Mensaje {
  User user;
  String texto;
  int hora;

  Mensaje(Map json)
      : user = User(json["user"]),
        texto = json["texto"],
        hora = json["hora"];
}
