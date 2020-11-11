import 'package:Karma/screen/ChatScreen.dart';
import 'package:Karma/screen/ListaScreen.dart';
import 'package:Karma/screen/SolicitarScreen.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _puntos = 2;
  bool _existeFavor = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0x00000000),
        title: Text("Karma"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              tooltip: 'Cerrar sesión',
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/bluedeg.jpg"), fit: BoxFit.cover)),
          child: SafeArea(
            child: Column(
              children: <Widget>[
                Center(
                  child: Column(
                    children: [
                      Text(
                        'Tus puntos de Karma:',
                      ),
                      Text(
                        '$_puntos',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ],
                  ),
                ),
                Container(
                    child: _existeFavor
                        ? Row(children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Categoría'),
                                Text('Lugar'),
                                Text('Estado'),
                                Text('Detalles')
                              ],
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ChatScreen()));
                                },
                                tooltip: 'Chat',
                                icon: Icon(Icons.chat))
                          ])
                        : Row(children: [
                            MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SolicitarScreen()));
                                },
                                child: Text('Pedir favor')),
                            MaterialButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ListaScreen()));
                                },
                                child: Text('Hacer favor'))
                          ])),
                Container(
                    child: MaterialButton(
                        onPressed: () {
                          setState(() {
                            _existeFavor = !_existeFavor;
                          });
                        },
                        child: _existeFavor
                            ? Text('Asumir que no hay favor en proceso')
                            : Text('Asumir que hay favor en proceso')))
              ],
            ),
          )),
    );
  }
}
