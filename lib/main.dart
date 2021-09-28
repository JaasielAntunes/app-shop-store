// @dart=2.9

import 'package:flutter/material.dart';
import 'package:loja_online/screens/home_screen.dart';
//import 'package:loja_online/screens/login_screen.dart';
//import 'package:loja_online/tabs/home_tab.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inicio Do Projeto',
      theme: ThemeData(
        // definição da cor de fundo do app
        primarySwatch: Colors.blue,
        primaryColor: Color.fromARGB(255, 4, 125, 141),
      ),
      // desativa a "fitinha vermelha debug"
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}