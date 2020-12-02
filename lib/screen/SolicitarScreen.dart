import 'package:Karma/providers/auth.dart';
import 'package:Karma/providers/favores.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SolicitarScreen extends StatefulWidget {
  @override
  _SolicitarScreenState createState() => _SolicitarScreenState();
}

class _SolicitarScreenState extends State<SolicitarScreen> {
  final _lugarController = TextEditingController();
  final _detalleController = TextEditingController();
  String _categoria = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _lugarController.dispose();
    _detalleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0x00000000),
      ),
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("images/bluedeg.jpg"), fit: BoxFit.cover)),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.fromLTRB(40, 20, 40, 40),
                  alignment: Alignment(0.0, 0.0),
                  child: Text(
                    '¿Que favor necesitas?',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(100, 0, 20, 0),
                    child: Column(
                        //crossAxisAlignment: CrossAxisAlignment.center,

                        children: <Widget>[
                          //https://www.youtube.com/watch?v=r5p-zhsrKUg&ab_channel=MobileProgrammer
                          RadioListTile(
                            value: "Sacar fotocopias",
                            groupValue: _categoria,
                            title: Text("Sacar fotocopias"),
                            onChanged: (val) {
                              setState(() {
                                _categoria = val;
                              });
                            },
                          ),

                          RadioListTile(
                            value: "Comprar en KM5",
                            groupValue: _categoria,
                            title: Text("Comprar en KM5"),
                            onChanged: (val) {
                              setState(() {
                                _categoria = val;
                              });
                            },
                          ),

                          RadioListTile(
                            value: "Buscar Domicilio en Puerta 7",
                            groupValue: _categoria,
                            title: Text("Buscar domicilio en Puerta 7"),
                            onChanged: (val) {
                              setState(() {
                                _categoria = val;
                              });
                            },
                          ),

                          RadioListTile(
                            value: "Favor especial",
                            groupValue: _categoria,
                            title: Text("Favor especial"),
                            onChanged: (val) {
                              setState(() {
                                _categoria = val;
                              });
                            },
                          ),
                        ])),
                Expanded(
                    child: Container(
                        child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(60, 20, 60, 20),
                      child: TextFormField(
                        //https://flutter.dev/docs/cookbook/forms/text-input
                        controller: _lugarController,
                        decoration: InputDecoration(labelText: "Lugar de entrega"),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                      child: TextFormField(
                        controller: _detalleController,
                        decoration: InputDecoration(labelText: "Detalles adicionales"),
                      ),
                    ),
                  ],
                ))),
                Container(
                    padding: const EdgeInsets.fromLTRB(60, 0, 60, 40),
                    alignment: Alignment(0.0, 0.6),
                    child: MaterialButton(
                        color: Colors.blue,
                        child: Text("SOLICITAR",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 18)),
                        onPressed: () {
                          if (_lugarController.text != "" &&
                              _detalleController.text != "" &&
                              _categoria != "") {
                            Provider.of<FavoresProvider>(context, listen: false).solicitarFavor(
                              Provider.of<AuthProvider>(context, listen: false).currentUser,
                              _lugarController.text,
                              _detalleController.text,
                              _categoria,
                            );
                            Navigator.of(context).pop();
                          }
                        }))
              ],
            ),
          )),
    );
  }
}
