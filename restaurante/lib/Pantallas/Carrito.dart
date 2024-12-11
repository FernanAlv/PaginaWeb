import 'package:flutter/material.dart';

class Carrito extends StatefulWidget {
  final List<Map<String, dynamic>> cart; // Recibir el carrito

  const Carrito(
    this.cart, {
    super.key,
  });

  @override
  _CarritoState createState() => _CarritoState();
}

class _CarritoState extends State<Carrito> {
  void _removeFromCart(int index) {
    setState(() {
      widget.cart.removeAt(index); // Eliminar el ítem del carrito
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito'),
      ),
      body: widget.cart.isEmpty
          ? const Center(child: Text('El carrito está vacío'))
          : ListView.builder(
              itemCount: widget.cart.length,
              itemBuilder: (context, index) {
                final item = widget.cart[index];
                return Container(
                  // Cambiado a un contenedor
                  color: Colors.white, // Fondo blanco
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: ListTile(
                    leading: Image.asset(
                      "images/${item['img']}.jpg", // Asume que las imágenes están en la carpeta correcta
                      width: 50,
                      height: 50,
                    ),
                    title: Text(item['img']),
                    subtitle: Text(
                        "\$${(item['price'] * item['quantity']).toStringAsFixed(2)} x ${item['quantity']}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _removeFromCart(
                            index); // Llamar a la función para eliminar el ítem
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
