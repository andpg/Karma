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
              (favor.userAsignado != null && favor.userAsignado.uid == user.uid)) {
            if (favor.estado == "Inicial" || favor.estado == "Asignado") {
              favorEnProceso = favor;
            } else if (favor.estado == "Completo") {
              favoresHechos.add(favor);
              favoresHechos.sort((Favor f1, Favor f2) => f2.horaCompletado - f1.horaCompletado);
            }
          } else if (favor.user.uid != user.uid && favor.estado == "Inicial") {
            favoresDisponibles.add(favor);
            favoresDisponibles.sort((Favor f1, Favor f2) => f2.user.karma - f1.user.karma);
          }
        }
      }
      notifyListeners();
    });
  }

  void solicitarFavor(User user, String lugar, String detalle, String categ) {
    String id = db.child("favores").push().key;
    db.child("favores").child(id).update({
      "id": id,
      "categoria": categ,
      "detalle": detalle,
      "estado": "Inicial",
      "lugar": lugar,
      "user": user.toJson(),
      "confirmado": false,
      "completado": false,
    });
  }

  void asignarFavor(Favor favor, User user) {
    favor.userAsignado = user;
    favor.estado = "Asignado";
    db.child("favores").child(favor.id).update(favor.toJson());
  }

  void cancelarFavorEnProceso(User user) {
    if (favorEnProceso != null) {
      if (favorEnProceso.user.uid == user.uid) {
        db.child("favores").child(favorEnProceso.id).update(null);
      } else if (favorEnProceso.userAsignado != null &&
          favorEnProceso.userAsignado.uid == user.uid) {
        favorEnProceso.userAsignado = null;
        favorEnProceso.estado = "Inicial";
        db.child("favores").child(favorEnProceso.id).update(favorEnProceso.toJson());
      }
    }
  }

  void confirmarFavorEnProceso(User user) {
    if (favorEnProceso != null) {
      if (favorEnProceso.user.uid == user.uid)
        favorEnProceso.completado = true;
      else if (favorEnProceso.userAsignado != null && favorEnProceso.userAsignado.uid == user.uid)
        favorEnProceso.confirmado = true;

      if (favorEnProceso.confirmado && favorEnProceso.completado) {
        favorEnProceso.estado = "Completo";
        favorEnProceso.horaCompletado = DateTime.now().millisecondsSinceEpoch;
        db.child("favores").child(favorEnProceso.id).update(favorEnProceso.toJson());

        db.child("users").child(favorEnProceso.user.uid).once().then((data) {
          User user = User(Map.from(data.value));
          user.karma = user.karma - 2;
          db.child("users").child(user.uid).update(user.toJson());
        });

        db.child("users").child(favorEnProceso.userAsignado.uid).once().then((data) {
          User userAsignado = User(Map.from(data.value));
          userAsignado.karma = userAsignado.karma + 1;
          db.child("users").child(userAsignado.uid).update(userAsignado.toJson());
        });
      } else {
        db.child("favores").child(favorEnProceso.id).update(favorEnProceso.toJson());
      }
    }
  }
}
