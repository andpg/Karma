import 'package:Karma/providers/auth.dart';
import 'package:Karma/providers/chat.dart';
import 'package:Karma/providers/favores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var _user;
  String _idFavor;
  final _textController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _user = Provider.of<AuthProvider>(context, listen: false).currentUser;
    _idFavor = Provider.of<FavoresProvider>(context, listen: false).favorEnProceso.id;
    Provider.of<ChatProvider>(context, listen: false).buscarMensajes(_idFavor);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0x00000000),
        title: Consumer<FavoresProvider>(builder: (context, provider, child) {
          if (provider.favorEnProceso.user.uid == _user.uid)
            return Text("Chat: ${provider.favorEnProceso.userAsignado.nombre}");
          else
            return Text("Chat: ${provider.favorEnProceso.user.nombre}");
        }),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("images/bluedeg.jpg"), fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Container(
                      child: Consumer<ChatProvider>(
                builder: (context, provider, child) => Column(
                    children: provider.mensajes
                        .map((mensaje) => mensaje.user.uid == _user.uid
                            ? Container(
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                  ),
                                ),
                                margin: EdgeInsets.only(left: 100, right: 20, bottom: 20),
                                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                alignment: Alignment(1.0, 0.0),
                                child: Text(
                                  '${mensaje.texto}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              )
                            : Container(
                                decoration: new BoxDecoration(
                                  color: Colors.lightBlue[100],
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30),
                                    topLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30),
                                  ),
                                ),
                                margin: EdgeInsets.only(left: 20, right: 100, bottom: 20),
                                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                alignment: Alignment(-1.0, 0.0),
                                child: Text(
                                  '${mensaje.texto}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ))
                        .toList()),
              ))),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 90, 20),
                child: TextFormField(
                  controller: _textController,
                  //https://flutter.dev/docs/cookbook/forms/text-input
                  decoration: InputDecoration(
                      filled: true, fillColor: Colors.white, labelText: "Escribe aquí tu mensaje!"),
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Provider.of<ChatProvider>(context, listen: false)
              .enviarMensaje(_idFavor, _user, _textController.text);
          _textController.clear();
        },
        tooltip: 'Enviar',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
