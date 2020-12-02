import 'package:Karma/model/mensaje.dart';
import 'package:Karma/model/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatProvider extends ChangeNotifier {
  final db = FirebaseDatabase.instance.reference();
  List<Mensaje> mensajes = new List();

  void buscarMensajes(String idFavor) {
    db.child("favores").child(idFavor).child("mensajes").onValue.listen((event) {
      mensajes.clear();

      if (event.snapshot.value != null) {
        Map jsonMensajes = Map.from(event.snapshot.value);
        for (Map json in jsonMensajes.values) {
          mensajes.add(Mensaje(json));
        }
      }
      notifyListeners();
    });
  }

  void enviarMensaje(String idFavor, User user, String texto) {
    db.child("favores").child(idFavor).child("mensajes").push().update({
      'user': user.toJson(),
      'texto': texto,
      'hora': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
