import 'package:flutter/material.dart';

class ListaScreen extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);
  // final String title;

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/bluedeg.jpg"),
                    fit: BoxFit.cover)),
            child: SafeArea(
              child: Container(),
            )));
  }
}
