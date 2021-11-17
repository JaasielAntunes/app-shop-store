import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_online/datas/cart_product.dart';
import 'package:loja_online/datas/product_data.dart';
import 'package:loja_online/models/cart_model.dart';
import 'package:loja_online/models/user_model.dart';
import 'package:loja_online/screens/cart_screen.dart';
import 'package:loja_online/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  // declaração do construtor para capturar os dados do produto a partir do Firebase.
  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;
  String size;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[700],
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            // Carousel: animações diversas para imagens
            child: Carousel(
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              // tamanho dos pontos de seleção da imagem
              dotSize: 4.0,
              // espaçamento entre os pontos
              dotSpacing: 15.0,
              // cor dos pontos
              dotBgColor: Colors.transparent,
              // mudança automática de imagem desligada
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  'R\$ ${product.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Tamanho',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 34,
                  child: GridView(
                    // espaçamento acima e abaixo
                    padding: EdgeInsets.symmetric(vertical: 4),
                    // orientação da grade
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      // alinhamento dos botões
                      crossAxisCount: 1,
                      mainAxisExtent: 60,
                      mainAxisSpacing: 17,
                    ),
                    children:
                        // capturando o produto atual e lista de tamanhos do firestore
                        product.sizes.map((s) {
                      return GestureDetector(
                        // selecionar qual tamanho do produto
                        onTap: () {
                          setState(() {
                            size = s;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color:
                                    s == size ? primaryColor : Colors.grey[700],
                                width: 3),
                          ),
                          width: 50,
                          alignment: Alignment.center,
                          child: Text(s),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16),
                SizedBox(
                  height: 43,
                  child: ElevatedButton(
                    // desabilitar botão
                    onPressed: size != null
                        ? () {
                            // context = busca de objeto do tipo UserModel
                            if (UserModel.of(context).isLogged()) {
                              // adicionar ao carrinho se estiver logado
                              CartProduct cartProduct = CartProduct();
                              cartProduct.size = size;
                              cartProduct.qtde = 1;
                              cartProduct.pid = product.id;
                              cartProduct.category = product.category;
                              cartProduct.prodData = product;

                              CartModel.of(context).addCartItem(cartProduct);

                              // ao adicionar produto ao carrinho direciona para a página do carrinho
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CartScreen()));
                            } else {
                              // caso contrário direcionar para o login
                              // context = busca de objeto do tipo Navigator
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                            }
                          }
                        : null,
                    child: Text(
                      UserModel.of(context).isLogged()
                          ? 'Adicionar ao Carrinho'
                          : 'Faça Login para realizar compra!',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.cyan[700]),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Descrição:',
                  style: GoogleFonts.ubuntu(
                    fontSize: 18,
                    color: primaryColor,
                  ),
                ),
                Text(
                  product.description,
                  style: GoogleFonts.rubik(
                    fontSize: 17,
                    color: Colors.yellow[900],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
