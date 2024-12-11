import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; // Importa el paquete de Google Maps
import 'MenuPage.dart'; // Asegúrate de importar MenuPage

class Home extends StatefulWidget {
  Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Controlador para el scroll
  final ItemScrollController _scrollController = ItemScrollController();

  // Controlador de Google Maps
  late GoogleMapController mapController;

  // Coordenadas del restaurante
  static const LatLng _restaurantLocation = LatLng(40.748817,
      -73.985428); // Ejemplo de coordenadas (cambia a las del restaurante)

  // Método para abrir un enlace externo
  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir el enlace: $url';
    }
  }

  // Método para redirigir al menú de comida
  void _goToMenuDeComida() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const MenuPage()), // Redirige a MenuPage
    );
  }

  // Método para crear el mapa
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF212121),
        title: const Text(
          'Mi Restaurante',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white, // Cambia el color del icono de menú a blanco
        ),
        actions: [
          // Botón de reserva
          ElevatedButton(
            onPressed: () {
              _launchURL("https://www.ejemplo.com/reservas");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFCCAA55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
            child: const Text(
              "RESERVA",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Botón para ir al menú de comida
          ElevatedButton(
            onPressed: _goToMenuDeComida, // Llamamos a la función para navegar
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFCCAA55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
            child: const Text(
              "MENÚ DE COMIDA",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      // Drawer (menú deslizante desde la izquierda)
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF212121),
              ),
              child: Text(
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
                _scrollController.scrollTo(
                    index: 0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title: const Text('Horarios'),
              onTap: () {
                _scrollController.scrollTo(
                    index: 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_page),
              title: const Text('Contacto'),
              onTap: () {
                _scrollController.scrollTo(
                    index: 2,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Quiénes Somos'),
              onTap: () {
                _scrollController.scrollTo(
                    index: 3,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),

      // Contenido de la página
      body: Stack(
        children: [
          // Contenido de la página
          ScrollablePositionedList.builder(
            itemScrollController: _scrollController,
            itemCount:
                5, // Se ha incrementado a 5 por la nueva sección del mapa
            itemBuilder: (context, index) {
              return _getSection(index);
            },
          ),
        ],
      ),
    );
  }

  // Widget para las secciones del contenido
  Widget _getSection(int index) {
    switch (index) {
      case 0:
        return _sectionContainer(
          "Inicio",
          "Bienvenido a nuestro restaurante. Descubre los mejores platillos en un ambiente único.",
        );
      case 1:
        return _sectionContainer(
          "Horarios",
          "Estamos abiertos todos los días de 9:00 AM a 10:00 PM. ¡Ven a visitarnos!",
        );
      case 2:
        return _sectionContainer(
          "Contacto",
          "Teléfono: +123 456 7890\nCorreo: contacto@restaurante.com\nDirección: Calle Principal #123, Ciudad, País",
        );
      case 3:
        return _sectionContainer(
          "Quiénes Somos",
          "Somos un restaurante comprometido con ofrecer experiencias gastronómicas únicas y memorables.",
        );
      case 4:
        return _sectionContainerWithMap();
      default:
        return const SizedBox();
    }
  }

  // Sección que muestra el mapa de Google
  Widget _sectionContainerWithMap() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Ubicación",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            "Visítanos en la siguiente ubicación para disfrutar de nuestros platillos.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 20),
          // Google Map
          SizedBox(
            height: 300, // Ajusta el tamaño del mapa
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _restaurantLocation,
                zoom: 15.0,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('restaurant'),
                  position: _restaurantLocation,
                  infoWindow: InfoWindow(
                    title: 'Restaurante',
                    snippet: 'Ubicación del Restaurante',
                  ),
                ),
              },
            ),
          ),
        ],
      ),
    );
  }

  // Contenedor genérico para cada sección
  Widget _sectionContainer(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
