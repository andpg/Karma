import 'package:Karma/providers/auth.dart';
import 'package:Karma/providers/favores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListaScreen extends StatefulWidget {
  @override
  _ListaScreenState createState() => _ListaScreenState();
}

class _ListaScreenState extends State<ListaScreen> {
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
              image: DecorationImage(image: AssetImage("images/bluedeg.jpg"), fit: BoxFit.cover)),
          child: SafeArea(
              child: Container(
                  child: Consumer<FavoresProvider>(
                      builder: (context, provider, child) => ListView(
                            children: ListTile.divideTiles(
                              context: context,
                              tiles: provider.favoresDisponibles
                                  .map((fav) => ListTile(
                                      onTap: () {
                                        provider.asignarFavor(
                                            fav,
                                            Provider.of<AuthProvider>(context, listen: false)
                                                .currentUser);
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
                                          Text('${fav.user.nombre}'),
                                        ]),
                                      ])))
                                  .toList(),
                            ).toList(),
                          ))))),
    );
  }
}
