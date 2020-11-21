import 'package:Karma/model/user.dart';

class Favor {
  String id;
  String categoria;
  String detalle;
  String estado;
  String lugar;
  User user;
  User userAsignado;
  Map mensajes;
  bool completado;
  bool confirmado;
  int horaCompletado;

  Favor(Map json)
      : id = json["id"],
        categoria = json["categoria"],
        detalle = json["detalle"],
        estado = json["estado"],
        lugar = json["lugar"],
        user = User(json["user"]),
        userAsignado = User(json["userAsignado"]),
        mensajes = json["mensajes"],
        completado = json["completado"],
        confirmado = json["confirmado"],
        horaCompletado = json["horaCompletado"];
}
