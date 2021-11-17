import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShipCard extends StatelessWidget {
  // NÃO está funcionando por enquanto.

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(
          'Calcular Frete',
          textAlign: TextAlign.start,
          style: GoogleFonts.kanit(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).primaryColor,
          ),
        ),
        leading: Icon(Icons.location_on, color: Colors.amber[800]),
        trailing:
            Icon(Icons.arrow_drop_down, color: Colors.amber[800], size: 31),
        children: [
          Padding(
            padding: EdgeInsets.all(7),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Informe o CEP',
              ),
              initialValue: '',
              onFieldSubmitted: (text) {},
            ),
          ),
        ],
      ),
    );
  }
}
