import 'package:flutter/material.dart';

class ListaScreen extends StatefulWidget {
  @override
  _ListaScreenState createState() => _ListaScreenState();
}

class Favor {
  String categoria;
  String lugar;
  String usuario;
  Favor(this.categoria, this.lugar, this.usuario);
}

class _ListaScreenState extends State<ListaScreen> {
  var _favores = <Favor>[
    Favor("Sacar fotocopias", "5K", "Celia Cruz"),
    Favor("Favor especial", "Cancha de Tenis", "Ruben Blades"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0x00000000),
          title: Text("Favores por hacer"),
          actions: [
            IconButton(
              onPressed: () {},
              tooltip: 'Filtrar',
              icon: Icon(Icons.filter_list),
            )
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/bluedeg.jpg"),
                    fit: BoxFit.cover)),
            child: SafeArea(
              child: Container(
                  child: ListView(
                      children: ListTile.divideTiles(
                context: context,
                tiles: _favores
                    .map((fav) => ListTile(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        contentPadding: EdgeInsets.all(10),
                        title: Text('${fav.categoria}',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(children: [
                          Row(children: [
                            Text('Lugar: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('${fav.lugar}'),
                          ]),
                          Row(children: [
                            Text('Lo pide: ',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text('${fav.usuario}'),
                          ]),
                        ])))
                    .toList(),
              ).toList())),
            )));
  }
}
