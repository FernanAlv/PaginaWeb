import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurante/Pantallas/single_item_screen.dart';

class ItemsWidget extends StatefulWidget {
  final Function(String, double, int)
      addToCart; // Callback para agregar al carrito
  final List<String> items; // Lista de elementos a mostrar
  final List<double> prices; // Lista de precios correspondientes a cada ítem
  final List<String> descriptions; // Lista de descripciones independientes

  const ItemsWidget({
    super.key,
    required this.addToCart,
    required this.items,
    required this.prices,
    required this.descriptions, // Requerir la lista de descripciones
  });

  @override
  // ignore: library_private_types_in_public_api
  _ItemsWidgetState createState() => _ItemsWidgetState();
}

class _ItemsWidgetState extends State<ItemsWidget> {
  List<int> quantities; // Lista para manejar cantidades independientes

  _ItemsWidgetState() : quantities = []; // Inicializar la lista de cantidades

  @override
  void initState() {
    super.initState();
    // Inicializar la lista de cantidades con 1 para cada ítem
    quantities = List<int>.filled(widget.items.length, 1);
  }

  @override
  Widget build(BuildContext context) {
    // Obtener el ancho de la pantalla
    final double screenWidth = MediaQuery.of(context).size.width;

    // Determinar el número de columnas según el ancho de la pantalla
    int crossAxisCount = (screenWidth < 600)
        ? 2
        : (screenWidth < 900)
            ? 3
            : 4;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: (150 /
            295), // Ajustar la proporción para que los cuadros sean 30px más largos
      ),
      itemCount: widget.items.length, // Cambiar a la longitud de items
      itemBuilder: (context, index) {
        String itemName = widget.items[index]; // Obtener el nombre del ítem
        double itemPrice = widget.prices[index]; // Obtener el precio del ítem
        String itemDescription =
            widget.descriptions[index]; // Obtener la descripción del ítem

        return Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFF212325),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SingleItemScreen(
                        itemName,
                        itemPrice, // Pasar el precio correspondiente
                        itemDescription, // Pasar la descripción correspondiente
                        widget.addToCart,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "images/$itemName.jpg", // Cambiar a usar el nombre del ítem
                    width: 100,
                    height: 100,
                    fit: BoxFit
                        .cover, // Cambiar a BoxFit.cover para llenar el espacio
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Ajustar tamaño de texto según el tamaño de la pantalla
                      Text(
                        itemName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: screenWidth < 600 ? 16 : 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        itemDescription, // Usar la descripción independiente
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Mostrar el precio en la parte superior
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "\$${itemPrice.toStringAsFixed(2)}", // Mostrar el precio correspondiente
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
              // Fila para los botones de incremento y decremento
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        if (quantities[index] > 1) {
                          quantities[index]--;
                        }
                      });
                    },
                  ),
                  Text(
                    '${quantities[index]}', // Mostrar la cantidad correspondiente
                    style: const TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        quantities[index]++;
                      });
                    },
                  ),
                ],
              ),
              // Icono de agregar al carrito centrado
              Center(
                child: IconButton(
                  icon: const Icon(
                    CupertinoIcons.add,
                    size: 20,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Agregar al carrito
                    widget.addToCart(itemName, itemPrice,
                        quantities[index]); // Agregar ítem al carrito
                    // Navegar al carrito
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
