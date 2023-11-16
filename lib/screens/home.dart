import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> tiposDeRepuestos = ['Tipo 1', 'Tipo 2', 'Tipo 3'];
  String selectedTipo = 'Tipo 1';
  String searchText = '';
  String filtroSeleccionado = 'Todos';

  void actualizarDatos() {
    // Lógica para actualizar datos (puedes implementar según tus necesidades)
    print('Datos actualizados');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventario de Repuestos'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: actualizarDatos,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  searchText = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Buscar repuestos',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: filtroSeleccionado,
              onChanged: (String? newValue) {
                setState(() {
                  filtroSeleccionado = newValue!;
                });
              },
              items: ['Todos', 'Filtro 1', 'Filtro 2', 'Filtro 3']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Text('Tipo de Repuesto: '),
                DropdownButton<String>(
                  value: selectedTipo,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTipo = newValue!;
                    });
                  },
                  items: tiposDeRepuestos
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text('Lista de repuestos basada en los filtros y selecciones'),
          ],
        ),
      ),
    );
  }
}
