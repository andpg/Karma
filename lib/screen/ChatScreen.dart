import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0x00000000),
        title: Text("Chat"),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bluedeg.jpg"), fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Container(
                      child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                    alignment: Alignment(-1.0, 0.0),
                    child: Text(
                      'Hola, ya voy en camino',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(40, 5, 40, 5),
                    alignment: Alignment(1.0, 0.0),
                    child: Text(
                      'Ok, te espero pronto. Gracias!',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20),
                    ),
                  ),
                ],
              ))),
              Container(
                padding: const EdgeInsets.fromLTRB(40, 20, 90, 20),
                child: TextFormField(
                  //https://flutter.dev/docs/cookbook/forms/text-input
                  decoration:
                      InputDecoration(labelText: "Escribe aquí tu mensaje!"),
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        tooltip: 'Enviar',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
