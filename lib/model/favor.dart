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

  Favor(
      this.id,
      this.categoria,
      this.detalle,
      this.estado,
      this.lugar,
      this.user,
      this.userAsignado,
      this.mensajes,
      this.completado,
      this.confirmado,
      this.horaCompletado);
}
