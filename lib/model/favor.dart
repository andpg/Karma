import 'package:Karma/model/mensaje.dart';
import 'package:Karma/model/user.dart';

class Favor {
  String id;
  String categoria;
  String detalle;
  String estado;
  String lugar;
  User user;
  User userAsignado;
  List<Mensaje> mensajes;
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
        userAsignado = json["userAsignado"] == null ? null : User(json["userAsignado"]),
        completado = json["completado"],
        confirmado = json["confirmado"],
        horaCompletado = json["horaCompletado"];

  Map toJson() => {
        'id': id,
        'categoria': categoria,
        'detalle': detalle,
        'estado': estado,
        'lugar': lugar,
        'user': user,
        'userAsignado': userAsignado,
        'completado': completado,
        'confirmado': confirmado,
        'horaCompletado': horaCompletado,
      };
}
