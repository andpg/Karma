import 'package:Karma/model/user.dart';

class Mensaje {
  String id;
  User user;
  String texto;
  int hora;

  Mensaje(this.id, this.user, this.texto, this.hora);
}
