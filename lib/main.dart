import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Karma/providers/auth.dart';
import 'package:Karma/providers/favores.dart';
import 'package:Karma/providers/chat.dart';
import 'screen/LoginScreen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthProvider()),
      ChangeNotifierProvider(create: (context) => FavoresProvider()),
      ChangeNotifierProvider(create: (context) => ChatProvider()),
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Karma',
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        accentColor: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}
