import 'package:Karma/providers/favores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Karma/providers/auth.dart';
import 'package:Karma/screen/ChatScreen.dart';
import 'package:Karma/screen/ListaScreen.dart';
import 'package:Karma/screen/SolicitarScreen.dart';

import 'LoginScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<FavoresProvider>(context, listen: false)
        .buscarFavores(Provider.of<AuthProvider>(context, listen: false).currentUser);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0x00000000),
        title: Text("Karma"),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<AuthProvider>(context, listen: false).signOut().then((success) {
                  if (success) {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (context) => LoginScreen()));
                  }
                });
              },
              tooltip: 'Cerrar sesión',
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("images/bluedeg.jpg"), fit: BoxFit.cover)),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Tus puntos de Karma:',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Consumer<AuthProvider>(
                        builder: (context, provider, child) => Text(
                          '${provider.currentUser.karma}',
                          style: TextStyle(color: Colors.black, fontSize: 56),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Últimos movimientos",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18)),
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    child: Consumer<FavoresProvider>(builder: (context, provider, child) {
                      List favores = provider.favoresHechos;
                      if (favores.length < 1)
                        return Container(
                          padding: EdgeInsets.all(10),
                          child: Text('Aun no has completado ningún favor.',
                              style: TextStyle(color: Colors.black, fontSize: 16)),
                        );
                      if (favores.length > 3) favores = favores.sublist(0, 3);
                      return Column(
                          children: favores
                              .map((favor) => Row(children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                          (favor.user.uid ==
                                                  Provider.of<AuthProvider>(context, listen: false)
                                                      .currentUser
                                                      .uid)
                                              ? "-1"
                                              : "+2",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 18)),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(favor.categoria,
                                          style: TextStyle(color: Colors.black, fontSize: 18)),
                                    ),
                                  ]))
                              .toList());
                    })),
                Container(
                  child: Consumer<FavoresProvider>(builder: (context, provider, child) {
                    var favor = provider.favorEnProceso;
                    if (favor == null)
                      return Row(children: [
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.all(10),
                          child: MaterialButton(
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => ListaScreen()));
                            },
                            child: Text('Hacer favores',
                                style: TextStyle(color: Colors.black, fontSize: 18)),
                          ),
                        )),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.all(10),
                          child: MaterialButton(
                            color: Colors.blue,
                            onPressed: () {
                              if (Provider.of<AuthProvider>(context, listen: false)
                                      .currentUser
                                      .karma <
                                  2) {
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    'Necesitas al menos 2 puntos de Karma para pedir favores.',
                                  ),
                                  action: SnackBarAction(
                                    label: 'X',
                                    onPressed: Scaffold.of(context).hideCurrentSnackBar,
                                  ),
                                ));
                              } else
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => SolicitarScreen()));
                            },
                            child: Text('Solicitar favor',
                                style: TextStyle(color: Colors.black, fontSize: 18)),
                          ),
                        )),
                      ]);
                    else
                      return Container(
                          decoration: new BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                          child: Stack(children: [
                            Positioned(
                              top: -5.0,
                              right: -5.0,
                              child: IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            content: Text(
                                              '¿Estas seguro de que quieres cancelar este favor?',
                                            ),
                                            actions: [
                                              MaterialButton(
                                                  onPressed: () {
                                                    Provider.of<FavoresProvider>(context,
                                                            listen: false)
                                                        .cancelarFavorEnProceso(
                                                            Provider.of<AuthProvider>(context,
                                                                    listen: false)
                                                                .currentUser);
                                                  },
                                                  child: Text('Sí')),
                                              MaterialButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('No')),
                                            ]);
                                      },
                                    );
                                  },
                                  tooltip: 'Cancelar',
                                  icon: Icon(
                                    Icons.close,
                                    size: 20.0,
                                  )),
                            ),
                            Column(children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Text("Favor en proceso",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 18)),
                              ),
                              Row(children: <Widget>[
                                Expanded(
                                    child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Text('${favor.categoria}',
                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Text('Lugar: ',
                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                          Text('${favor.lugar}')
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Text('Estado: ',
                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                          Text('${favor.estado}')
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      child: Row(
                                        children: [
                                          Text('Detalles: ',
                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                          Text('${favor.detalle}')
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                                favor.estado == "Asignado"
                                    ? Column(children: [
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                      content: Text(
                                                        '¿Estas seguro de que quieres marcar este favor como completado?',
                                                      ),
                                                      actions: [
                                                        MaterialButton(
                                                            onPressed: () {
                                                              Provider.of<FavoresProvider>(context,
                                                                      listen: false)
                                                                  .confirmarFavorEnProceso(
                                                                      Provider.of<AuthProvider>(
                                                                              context,
                                                                              listen: false)
                                                                          .currentUser);
                                                            },
                                                            child: Text('Sí')),
                                                        MaterialButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop();
                                                            },
                                                            child: Text('No')),
                                                      ]);
                                                },
                                              );
                                            },
                                            tooltip: 'Completar',
                                            icon: Icon(
                                              Icons.done_outline,
                                              size: 30.0,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => ChatScreen()));
                                            },
                                            tooltip: 'Chat',
                                            icon: Icon(
                                              Icons.chat_outlined,
                                              size: 30.0,
                                            )),
                                      ])
                                    : Text('')
                              ])
                            ])
                          ]));
                  }),
                )
              ],
            ),
          )),
    );
  }
}
