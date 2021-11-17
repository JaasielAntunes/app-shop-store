import 'package:flutter/material.dart';
import 'package:loja_online/datas/product_data.dart';
import 'package:loja_online/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    // InkWell faz uma animação de toque na tela.
    // parte com forma em grade.
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductScreen(product)));
      },
      child: Card(
        child: type == 'grid'
            ?
            // se o tipo for grade retorna em coluna
            Column(
                // utilizando o stretch para esticar as imagens.
                crossAxisAlignment: CrossAxisAlignment.stretch,
                // utilizando o start para as imagens começarem a partir do topo.
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AspectRatio(
                    // definição da largura e altura da imagem
                    aspectRatio: 0.9,
                    child: Image.network(
                      product.images[0],
                      // BoxFit para cobrir todo espaço possivel.
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(
                            product.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            // para usar o $ deve colocar uma barra invertida antes.
                            // toStringAsFixed para mostrar 2 casas decimais do preço.
                            'R\$ ${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            :
            // se o tipo não for coluna então retorna em linha
            Row(
                // parte com forma em lista.
                children: [
                  Flexible(
                    flex: 1,
                    child: Image.network(
                      product.images[0],
                      fit: BoxFit.cover,
                      height: 240,
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.title,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'R\$ ${product.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
