import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_online/datas/product_data.dart';
import 'package:loja_online/tiles/product_tile.dart';

// código para indicação de categorias, busca e exibição dos items da categoria

class CategoryScreen extends StatelessWidget {
  // snapshot para indicar de qual categoria é
  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    // DefaultTabController usado para inserir Tabs.
    return DefaultTabController(
      // definir quantas tabs vai ter
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.cyan[700],
          // capturando title do Firebase
          title: Text(snapshot['title']),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              // icones de escolha entre grade ou lista
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list)),
            ],
          ),
        ),

        // QuerySnapshot é um tipo de função para acessar coleções
        body: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance
                .collection('products')
                .doc(snapshot.id)
                .collection('items')
                .get(),
            // snapshot indicando cada documento da categoria
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(
                  child: CircularProgressIndicator(),
                );
              else
                return TabBarView(
                  // não permitir que arraste para o lado
                  //physics: NeverScrollableScrollPhysics(),
                  children: [
                    GridView.builder(
                        padding: EdgeInsets.all(5),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          childAspectRatio: 0.70,
                        ),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          ProductData data = ProductData.fromDocument(
                              snapshot.data.docs[index]);
                          data.category = this.snapshot.id;

                          if (!snapshot.hasData)
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          return ProductTile('grid', data);
                        }),
                    ListView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          if (!snapshot.hasData)
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          ProductData data = ProductData.fromDocument(
                              snapshot.data.docs[index]);
                          data.category = this.snapshot.id;

                          return ProductTile('list', data);
                        }),
                  ],
                );
            }),
      ),
    );
  }
}
