import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Karma/screen/HomeScreen.dart';
import 'package:Karma/auth.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bumeran2.jpg"), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(50),
                alignment: Alignment(0.0, -0.7),
                child: Text(
                  '¡Bienvenido a Karma!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 25),
                ),
              ),
            ),
            Expanded(
                child: Container(
                    padding: const EdgeInsets.all(30),
                    alignment: Alignment(0.0, 0.7),
                    child: FlatButton(
                        color: Colors.blueAccent,
                        child: Text("ENTRA CON GOOGLE",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 18)),
                        onPressed: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .signInWithGoogle()
                              .then((success) => {
                                    if (success)
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()),
                                      )
                                  });
                        })))
          ],
        ),
      ),
    );
  }
}
