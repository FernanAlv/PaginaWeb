import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurante/Pantallas/Carrito.dart'; // Asegúrate de que esta ruta sea correcta
import 'package:restaurante/Pantallas/PantallaHome.dart';

class HomeBottomBar extends StatelessWidget {
  final List<Map<String, dynamic>>
      cart; // Tipo de dato según tu implementación del carrito

  const HomeBottomBar(
      {super.key, required this.cart}); // Recibe el carrito como parámetro

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF212325),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 8,
          )
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Home(),
                ),
              );
            },
            child: const Icon(
              Icons.home,
              color: Color(0xFFE57734),
              size: 35,
            ),
          ),
          const Icon(
            Icons.favorite_outlined,
            color: Colors.white,
            size: 35,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Carrito(
                      cart), // Asegúrate de que Carrito tenga este constructor
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellow, // Color de fondo amarillo
                shape: BoxShape.circle, // Hacer que el contenedor sea circular
              ),
              padding: const EdgeInsets.all(10), // Padding para el círculo
              child: Icon(
                CupertinoIcons.shopping_cart,
                size: 35,
                color: Colors.black, // Cambiar color del icono a negro
              ),
            ),
          ),
          const Icon(
            Icons.notifications,
            color: Colors.white,
            size: 35,
          ),
          const Icon(
            Icons.person,
            color: Colors.white,
            size: 35,
          ),
        ],
      ),
    );
  }
}
