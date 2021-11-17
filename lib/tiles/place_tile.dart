import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceTile extends StatelessWidget {
  // acesso aos documentos no banco de dados através do snapshot
  final DocumentSnapshot snapshot;
  PlaceTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 100,
            child: Image.network(
              snapshot['image'],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  snapshot['title'],
                  textAlign: TextAlign.start,
                  style: GoogleFonts.kanit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  snapshot['address'],
                  textAlign: TextAlign.start,
                  style: GoogleFonts.kanit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  launch(
                      "https://www.google.com/maps/search/?api=1&query=${snapshot["lat"]},"
                      "${snapshot["long"]}");
                },
                child: Text(
                  'Ver no mapa',
                  style: GoogleFonts.kanit(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                  ),
                ),
                style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(10)),
                ),
              ),
              TextButton(
                onPressed: () {
                  launch('tel:${snapshot['phone']}');
                },
                child: Text(
                  'Ligar',
                  style: GoogleFonts.kanit(
                    color: Theme.of(context).primaryColor,
                    fontSize: 18,
                  ),
                ),
                style: ButtonStyle(
                  padding:
                      MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
