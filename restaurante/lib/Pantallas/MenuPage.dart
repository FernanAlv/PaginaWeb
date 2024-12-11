import 'package:flutter/material.dart';
import 'PantallaHome.dart'; // Asegúrate de importar PantallaHome

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text("Menú de Comida"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Cambia el ícono si lo deseas
          onPressed: () {
            // Redirige a PantallaHome cuando se hace clic en el ícono
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Home()), // Redirige a PantallaHome
            );
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.orange,
              ),
              child: const Text(
                'Menú',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Inicio'),
              onTap: () {
                Navigator.pop(context); // Redirige a PantallaHome
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Home()), // Redirige a PantallaHome
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_online),
              title: const Text('Reserva'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(8),
          children: const <Widget>[
            MenuItemWidget(
              name: "Cafe",
              description: "Deliciosa bebida de café.",
              price: 3.99,
            ),
            MenuItemWidget(
              name: "Camarones",
              description: "Camarones frescos con salsa especial.",
              price: 12.99,
            ),
            MenuItemWidget(
              name: "Coca Cola",
              description: "Refresco de cola clásico.",
              price: 1.50,
            ),
            MenuItemWidget(
              name: "Pepsi",
              description: "Refresco Pepsi refrescante.",
              price: 1.50,
            ),
            MenuItemWidget(
              name: "Tiramisu",
              description: "Delicioso postre italiano.",
              price: 6.99,
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  final String name;
  final String description;
  final double price;

  const MenuItemWidget({
    super.key,
    required this.name,
    required this.description,
    required this.price,
  });

  // Método para obtener la ruta de la imagen basado en el nombre del producto
  String getImagePath() {
    return 'images/$name.jpg'; // Asumiendo que las imágenes están en 'images/[nombre].jpg'
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: <Widget>[
            // Imagen del producto
            Image.asset(
              getImagePath(), // Llama al método para obtener la ruta de la imagen
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 16),
            // Detalles del producto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "\$${price.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
