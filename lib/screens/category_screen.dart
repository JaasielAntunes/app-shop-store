import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_online/datas/product_data.dart';
import 'package:loja_online/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  // declarando construtor para receber o documento da categoria
  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    // DefaultTabController usado para inserir Tabs.
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          // capturando title do Firebase
          title: Text(snapshot.data['title']),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list)),
            ],
          ),
        ),
        // QuerySnapshot é um tipo de função para acessar coleções snapshot
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection('products').document(snapshot.documentID)
          .collection('items').getDocuments(),
          // ignore: missing_return
          builder: (context, snapshot) {
          if (!snapshot.hasData) 
            return Center(
              child: CircularProgressIndicator(),
            );
           else 
            TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                GridView.builder(
                  padding: EdgeInsets.all(4),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                   crossAxisCount: 2,
                   mainAxisSpacing: 4,
                   crossAxisSpacing: 4,
                   childAspectRatio: 0.70, 
                  ),
                  itemCount: snapshot.data.documents.length, 
                  itemBuilder: (context, index) {
                    return ProductTile('gride', ProductData.fromDocument(snapshot.data.documents[index])); 
                  }
                ),
                ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: snapshot.data.documents.length, 
                  itemBuilder: (context, index) {
                    return ProductTile('list', ProductData.fromDocument(snapshot.data.documents[index]));
                  }
                ),
              ],
            );
        }),
      ),
    );
  }
}
