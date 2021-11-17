import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loja_online/models/user_model.dart';
import 'package:loja_online/screens/login_screen.dart';
import 'package:loja_online/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  // construtor para navegação de páginas
  final PageController pageController;
  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    // função para definições da gaveta(drawer)
    Widget _drawerBack() => Container(
          // customização do Drawer
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 203, 235, 240),
              Colors.white,
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
        );

    return Drawer(
      child: Stack(
        children: [
          _drawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32, top: 15),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.fromLTRB(0, 15, 15, 8),
                height: 170,
                child: Stack(
                  children: [
                    Positioned(
                      top: 30,
                      left: 0,
                      child: RichText(
                        text: TextSpan(
                          text: 'Shop ',
                          style: GoogleFonts.francoisOne(
                              fontSize: 35, color: Colors.black),
                          children: const <TextSpan>[
                            TextSpan(
                                text: 'Store',
                                style: TextStyle(
                                  color: Colors.cyan,
                                )),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 168, top: 15),
                      child: Row(
                        children: [
                          // icone do App
                          Image.network(
                            'https://indyme.com/wp-content/uploads/2020/11/shopping-cart-icon.png',
                            width: 55,
                            height: 55,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 3,
                      bottom: 0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  // mostrar nome do usuário se caso estiver logado
                                  'Olá, ${!model.isLogged() ? '' : model.userData['name']}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Text(
                                  // se estiver logado = Entre ou cadastre-se
                                  // caso contrário o usuário logado pode sair da conta
                                  !model.isLogged()
                                      ? 'Entre ou cadastre-se >'
                                      : 'Sair',
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onTap: () {
                                  if (!model.isLogged())
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => LoginScreen(),
                                      ),
                                    );
                                  else
                                    model.signOut();
                                },
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // linha de divisão
              Divider(thickness: 1, color: Theme.of(context).primaryColor),
              // informações capturadas a partir do construtor DrawerTile()
              // cada um dos icones vai ser capaz de acionar o pageController e alterar a página
              DrawerTile(Icons.home, 'Inicio', pageController, 0),
              DrawerTile(Icons.list, 'Produtos', pageController, 1),
              DrawerTile(
                  Icons.playlist_add_check, 'Meus Pedidos', pageController, 2),
              DrawerTile(Icons.location_on, 'Lojas', pageController, 3),
            ],
          ),
        ],
      ),
    );
  }
}
