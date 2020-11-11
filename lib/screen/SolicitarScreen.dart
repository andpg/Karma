import 'package:flutter/material.dart';


class SolicitarScreen extends StatefulWidget {
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
  _SolicitarScreenState createState() => _SolicitarScreenState();
}

class _SolicitarScreenState extends State<SolicitarScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("images/bluedeg.jpg"), fit: BoxFit.cover) //agrefar en pubspec.yaml
        ),
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Container(
              padding: const EdgeInsets.fromLTRB(40, 40, 15, 20),
              alignment: Alignment(1.0,-1.0),
              child:FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: Icon(Icons.arrow_back),
              ), 
            ),

            Container(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 40),
              alignment: Alignment(0.0,0.0),
              child: Text(
                '¿Que favor necesitas?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 30),
              ),
            ),

            Container(
              
              padding: const EdgeInsets.fromLTRB(100, 0, 20, 0),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                
                children:<Widget>[
                  
                  //https://www.youtube.com/watch?v=r5p-zhsrKUg&ab_channel=MobileProgrammer
                  RadioListTile(
                    value: 1,
                    groupValue: 1,
                    title: Text("Sacar Fotocopias"),
                    onChanged: (val) {
                      
                    },
                    ),

                  RadioListTile(value: 0,
                    groupValue: 1,
                    title: Text("Comprar en K5"),
                    onChanged: (val) {
                      
                    },
                    ),

                  RadioListTile(value: 0,
                    groupValue: 1,
                    title: Text("Buscar Domicilio En Puerta 7"),
                    onChanged: (val) {
                      
                    },
                    ),

                  RadioListTile(value: 0,
                    groupValue: 1,
                    title: Text("Favor Especial"),
                    onChanged: (val) {
                      
                    },
                    ),

                ]
              )
             
            ),

            Expanded(child: Container(child:Column(children: <Widget>[
              Container(
              padding: const EdgeInsets.fromLTRB(60, 20, 60, 20),
              child: TextFormField( //https://flutter.dev/docs/cookbook/forms/text-input
                decoration: InputDecoration(
                  labelText: "Lugar de entrega"
                ),
              ),
              ),

              Container(
                padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                child: TextFormField( 
                  decoration: InputDecoration(
                    labelText: "Detalles adicionales"
                  ),
                ),
              ),
            ],))),
            
            


            Container(
              padding: const EdgeInsets.fromLTRB(60, 0, 60, 40),
              alignment: Alignment(0.0,0.6),
              child: FlatButton(
                color: Colors.white,
                child: Text(
                  "SOLICITAR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18)
                  ),
               
                onPressed: () {          
                }
              )
            )
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
