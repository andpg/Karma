import 'package:flutter/material.dart';

class SolicitarScreen extends StatefulWidget {
  @override
  _SolicitarScreenState createState() => _SolicitarScreenState();
}

class _SolicitarScreenState extends State<SolicitarScreen> {
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
              image: DecorationImage(
                  image: AssetImage("images/bluedeg.jpg"), fit: BoxFit.cover)),
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
                            value: 1,
                            groupValue: 1,
                            title: Text("Sacar Fotocopias"),
                            onChanged: (val) {},
                          ),

                          RadioListTile(
                            value: 0,
                            groupValue: 1,
                            title: Text("Comprar en K5"),
                            onChanged: (val) {},
                          ),

                          RadioListTile(
                            value: 0,
                            groupValue: 1,
                            title: Text("Buscar Domicilio En Puerta 7"),
                            onChanged: (val) {},
                          ),

                          RadioListTile(
                            value: 0,
                            groupValue: 1,
                            title: Text("Favor Especial"),
                            onChanged: (val) {},
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
                        decoration:
                            InputDecoration(labelText: "Lugar de entrega"),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                      child: TextFormField(
                        decoration:
                            InputDecoration(labelText: "Detalles adicionales"),
                      ),
                    ),
                  ],
                ))),
                Container(
                    padding: const EdgeInsets.fromLTRB(60, 0, 60, 40),
                    alignment: Alignment(0.0, 0.6),
                    child: FlatButton(
                        color: Colors.white,
                        child: Text("SOLICITAR",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.black, fontSize: 18)),
                        onPressed: () {}))
              ],
            ),
          )),
    );
  }
}
