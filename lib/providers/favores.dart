import 'package:Karma/model/favor.dart';
import 'package:Karma/model/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class FavoresProvider extends ChangeNotifier {
  final db = FirebaseDatabase.instance.reference();

  Favor favorEnProceso;
  List<Favor> favoresDisponibles = new List();
  List<Favor> favoresHechos = new List();

  void buscarFavores(User user) {
    db.child("favores").onValue.listen((event) {
      favorEnProceso = null;
      favoresDisponibles.clear();
      favoresHechos.clear();

      if (event.snapshot.value != null) {
        Map favores = Map.from(event.snapshot.value);
        for (Map map in favores.values) {
          Favor favor = Favor(map);
          if ((favor.user.uid == user.uid) ||
              (favor.userAsignado != null &&
                  favor.userAsignado.uid == user.uid)) {
            if (favor.estado == "Inicial" || favor.estado == "Asignado") {
              favorEnProceso = favor;
            } else if (favor.estado == "Completo") {
              favoresHechos.add(favor);
              favoresHechos.sort((Favor f1, Favor f2) =>
                  f2.horaCompletado - f1.horaCompletado);
            }
          } else if (favor.user.uid != user.uid && favor.estado == "Inicial") {
            favoresDisponibles.add(favor);
            favoresDisponibles
                .sort((Favor f1, Favor f2) => f2.user.karma - f1.user.karma);
          }
        }
      }
      notifyListeners();
    });
  }

  void solicitarFavor(User user, String lugar, String detalle, String categ) {}
  void asignarFavor(Favor favor, User user) {}
  void cancelarFavorEnProceso(User user) {}
  void confirmarFavorEnProceso(User user) {}
}
