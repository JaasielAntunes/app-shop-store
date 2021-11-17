import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderScreen extends StatelessWidget {
  final String orderId;
  OrderScreen(this.orderId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text(
          'Pedido Realizado!',
          style: GoogleFonts.kanit(
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_box,
              color: Theme.of(context).primaryColor,
              size: 90,
            ),
            SizedBox(height: 10),
            Text(
              'Pedido realizado com sucesso!',
              style: GoogleFonts.kanit(
                fontSize: 22,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Código do pedido: $orderId',
              style: GoogleFonts.kanit(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
