import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_online/screens/category_screen.dart';

class CategoryTile extends StatelessWidget {
  
  final DocumentSnapshot snapshot;
  // construtor para definição da categoria
  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        // capturando a imagem a partir do banco de dados
        backgroundImage: NetworkImage(snapshot.data['icon']),
      ),
      title: Text(snapshot.data['title']),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        // clicando em alguma das categorias vai abrir a tela daquela categoria
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>CategoryScreen(snapshot))
        );
      }
    );
  }
}