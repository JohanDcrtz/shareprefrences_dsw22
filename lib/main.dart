import 'package:flutter/material.dart';
import 'package:shareprefrences_dsw22/screens/home.dart';
import 'package:shareprefrences_dsw22/screens/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventario de Repuestos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthenticationWrapper(),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Añade lógica para verificar si el usuario está autenticado
    final bool isAuthenticated = true; // Reemplaza esto con tu lógica de autenticación

    // Si el usuario está autenticado, muestra la pantalla de inicio, de lo contrario, muestra la página de inicio de sesión.
    return isAuthenticated ? HomeScreen() : LoginPage();
  }
}
