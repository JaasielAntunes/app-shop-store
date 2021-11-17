import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_online/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(
          'Cupom de desconto',
          textAlign: TextAlign.start,
          style: GoogleFonts.kanit(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
        leading: Icon(Icons.card_giftcard, color: Colors.green),
        trailing: Icon(Icons.add, color: Colors.green),
        children: [
          Padding(
            padding: EdgeInsets.all(7),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Código do cupom',
              ),
              initialValue: CartModel.of(context).couponCode ?? '',
              onFieldSubmitted: (text) {
                // captura o cupom do banco de dados
                FirebaseFirestore.instance
                    .collection('coupons')
                    .doc(text)
                    .get()
                    .then((docSnap) {
                  // verifica se o cupom existe ou não
                  if (docSnap.data() != null) {
                    CartModel.of(context)
                        .applyCoupon(text, docSnap.data()['percent']);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Desconto de ${docSnap.data()['percent']}% aplicado!'),
                        backgroundColor: Theme.of(context).primaryColor,
                        duration: Duration(seconds: 5),
                      ),
                    );
                  } else {
                    CartModel.of(context).applyCoupon(null, 0);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('O cupom não existe!'),
                        backgroundColor: Colors.redAccent,
                        duration: Duration(seconds: 5),
                      ),
                    );
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
