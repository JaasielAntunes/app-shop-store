import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_online/tiles/category_tile.dart';

class ProductsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // capturando dados a partir do Firebase
    return FutureBuilder<QuerySnapshot>(
        // coleção products
        future: Firestore.instance.collection('products').getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            // barrinha de divisão entre cada categoria
            var dividedTiles = ListTile.divideTiles(
                    tiles: snapshot.data.documents.map((doc) {
                      return CategoryTile(doc);
                    }).toList(),
                    color: Colors.grey[500])
                .toList(); // toList() transforma as tiles em uma lista

            return ListView(
              children: dividedTiles,
            );
          }
        });
  }
}
