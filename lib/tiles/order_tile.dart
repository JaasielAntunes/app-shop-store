import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderTile extends StatelessWidget {
  final String orderId;
  OrderTile(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        // StreamBuilder alterações em tempo real
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('orders')
                .doc(orderId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else {
                int status = snapshot.data['status'];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Código do pedido: ${snapshot.data.id}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      _buildProductsText(snapshot.data),
                      style: GoogleFonts.kanit(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Status do pedido:',
                      style: GoogleFonts.kanit(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCircle('1', 'Preparação', status, 1),
                        // linha de separação entre os status
                        _line(),

                        _buildCircle('2', 'Transporte', status, 2),
                        // linha de separação entre os status
                        _line(),

                        _buildCircle('3', 'Entrega', status, 3),
                      ],
                    ),
                  ],
                );
              }
            }),
      ),
    );
  }

  // função para navegar por cada produto e mostrar suas informações
  String _buildProductsText(DocumentSnapshot snapshot) {
    String text = 'Descrição:\n';
    // lista com os produtos no banco de dados
    // capturando dados do banco de dados
    for (LinkedHashMap p in snapshot['products']) {
      // LinkedHashMap é o tipo de lista do banco de dados
      // toStringAsFixed(2) para mostrar apenas dois digitos do preço
      text +=
          '${p['qtde']} x ${p['product']['title']} (R\$ ${p['product']['price'].toStringAsFixed(2)})\n';
    }
    text += 'Total: R\$ ${snapshot['totalPrice'].toStringAsFixed(2)}';
    return text;
  }

  // função para mostrar status do pedido
  Widget _buildCircle(
      String title, String subtitle, int status, int thisStatus) {
    Color backColor;
    Widget child;

    if (status < thisStatus) {
      backColor = Colors.grey[500];
      child = Text(title, style: TextStyle(color: Colors.white));
    } else if (status == thisStatus) {
      backColor = Colors.cyan[700];
      child = Stack(
        alignment: Alignment.center,
        children: [
          Text(title, style: TextStyle(color: Colors.white)),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      );
    } else {
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white);
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subtitle),
      ],
    );
  }

  // função para exibir linha de separação entre os status
  Widget _line() {
    return Container(
      height: 1,
      width: 40,
      color: Colors.grey[500],
    );
  }
}
