import 'package:flutter/material.dart';
import 'package:restaurante/Pantallas/Home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurante Palma',
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFF212325)),
      initialRoute: '/',
      routes: {
        '/': (context) => const PantallaBienvenida(),
      },
    );
  }
}
