// @dart=2.9
import 'package:flutter/material.dart';
import 'package:loja_online/models/cart_model.dart';
import 'package:loja_online/models/user_model.dart';
import 'package:loja_online/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // toda alteração no app será modificada pelo ScopedModel
    return ScopedModel<UserModel>(
      model: UserModel(),
      // ao trocar usuário refazer o carrinho usando ScopedModelDescedant
      child: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        return ScopedModel<CartModel>(
          // acesso ao modelo do carrinho
          model: CartModel(model),
          child: MaterialApp(
            title: 'Shop Store',
            theme: ThemeData(
              // definição da cor de fundo do app
              primarySwatch: Colors.blue,
              primaryColor: Color.fromARGB(255, 4, 125, 141),
            ),
            // desativa a "fitinha vermelha" debug
            debugShowCheckedModeBanner: false,
            home: HomeScreen(),
          ),
        );
      }),
    );
  }
}
