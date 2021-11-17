import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_online/models/cart_model.dart';
import 'package:loja_online/models/user_model.dart';
import 'package:loja_online/screens/login_screen.dart';
import 'package:loja_online/screens/order_screen.dart';
import 'package:loja_online/tabs/cart_price.dart';
import 'package:loja_online/tabs/discount_card.dart';
import 'package:loja_online/tabs/ship_card.dart';
import 'package:loja_online/tiles/cart_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Center(
          child: Text(
            'Meu Carrinho',
            style: GoogleFonts.kanit(
              fontSize: 23,
              color: Colors.white,
            ),
          ),
        ),
        actions: [
          Container(
            // alinhamento do nome ITENS
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int prod = model.products.length;
                return Text(
                  // se prod for null retorna 0
                  // caso contrário retorna prod
                  '${prod ?? 0} ${prod == 1 ? "ITEM" : "ITENS"}',
                  style: GoogleFonts.kanit(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
          // ignore: missing_return
          builder: (context, child, model) {
        if (model.isLoading && UserModel.of(context).isLogged()) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!UserModel.of(context).isLogged()) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.remove_shopping_cart,
                    size: 80, color: Theme.of(context).primaryColor),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Faça Login para adicionar produtos.',
                  style: GoogleFonts.notoSans(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  child: Text(
                    'LOGIN',
                    style: GoogleFonts.kanit(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.cyan[700]),
                    fixedSize: MaterialStateProperty.all<Size>(Size(50, 50)),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                ),
              ],
            ),
          );
          // verifica se contém itens no carrinho
        } else if (model.products == null || model.products.length == 0) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Nenhum produto no carrinho!',
                  style: GoogleFonts.kanit(
                    color: Colors.redAccent,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12),
                Icon(Icons.remove_shopping_cart_outlined,
                    size: 80, color: Theme.of(context).primaryColor),
              ],
            ),
          );
        } else {
          // exibe uma lista com os itens do carrinho
          return ListView(
            children: [
              Column(
                // mapeando os produtos e retornando um CartTile() com informações do produto
                children: model.products.map((product) {
                  return CartTile(product);
                }).toList(),
              ),
              // 3 classes com finalidades diferentes
              DiscountCard(),
              ShipCard(),
              CartPrice(() async {
                // retornar ID do pedido
                String orderId = await model.finishOrder();
                if (orderId != null)
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => OrderScreen(orderId)),
                  );
              }),
            ],
          );
        }
      }),
    );
  }
}
