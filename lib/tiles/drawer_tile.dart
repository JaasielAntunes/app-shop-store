import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  // construtor para definir os icones e os textos
  final IconData icon;
  final String text;
  final PageController controller;
  final int page;

  DrawerTile(this.icon, this.text, this.controller, this.page);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          controller.jumpToPage(page);
        },
        child: Container(
          height: 60,
          child: Row(
            children: [
              Icon(
                icon,
                size: 30,
                color: controller.page.round() == page
                    ? Theme.of(context).primaryColor
                    : Colors.grey[700],
              ),
              // espaçamento entre o icone e o texto
              SizedBox(
                width: 30,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  // se a página atual do controlador for igual a do item aciona a primaryColor
                  // caso contrario coloca cinza.
                  // round() para arredondar o valor double para int.
                  color: controller.page.round() == page
                      ? Theme.of(context).primaryColor
                      : Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
