// lib/screens/inventario_screen.dart
import 'package:flutter/material.dart';

class InventarioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventario de Repuestos'),
      ),
      body: Center(
        child: Text('Contenido del inventario aquí'),
      ),
    );
  }
}
