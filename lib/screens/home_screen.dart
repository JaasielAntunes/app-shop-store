import 'package:flutter/material.dart';
import 'package:loja_online/drawers/custom_drawer.dart';
import 'package:loja_online/tabs/home_tab.dart';
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
        ),
        Scaffold(
          appBar: AppBar(
            title: Text('Produtos'),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
        ),
      ],
    );
  }
}