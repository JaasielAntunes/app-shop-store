import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_online/drawers/cart_button.dart';
import 'package:loja_online/drawers/custom_drawer.dart';
import 'package:loja_online/tabs/home_tab.dart';
import 'package:loja_online/tabs/orders_tab.dart';
import 'package:loja_online/tabs/places_tab.dart';
import 'package:loja_online/tabs/products_tab.dart';

class HomeScreen extends StatelessWidget {
  // definição de um controlador para as páginas
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.cyan[700],
            title: Text(
              'Produtos',
              style: GoogleFonts.kanit(
                fontSize: 24,
              ),
            ),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: ProductsTab(),
          ),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.cyan[700],
            title: Text(
              'Meus Pedidos',
              style: GoogleFonts.kanit(
                fontSize: 24,
              ),
            ),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.cyan[700],
            title: Text(
              'Lojas',
              style: GoogleFonts.kanit(
                fontSize: 24,
              ),
            ),
            centerTitle: true,
          ),
          body: PlacesTab(),
          drawer: CustomDrawer(_pageController),
        ),
      ],
    );
  }
}
