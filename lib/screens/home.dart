import 'package:flutter/material.dart';
import 'package:shareprefrences_dsw22/screens/servicios_screen.dart';
import 'package:shareprefrences_dsw22/screens/perfil_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<String> tiposDeRepuestos = ['Tipo 1', 'Tipo 2', 'Tipo 3'];
  String selectedTipo = 'Tipo 1';
  String searchText = '';
  String filtroSeleccionado = 'Todos';

  void actualizarDatos() {
    // Simulación de actualización de datos
    // Aquí deberías llamar a tu lógica real para actualizar los datos
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
            _buildSearchField(),
            SizedBox(height: 16.0),
            _buildFilterDropdown(),
            SizedBox(height: 16.0),
            _buildTipoRepuestoDropdown(),
            SizedBox(height: 16.0),
            _buildRepuestosList(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Repuestos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Servicios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onNavigationItemSelected,
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          searchText = value;
        });
      },
      decoration: InputDecoration(
        labelText: 'Buscar repuestos',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.search),
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return DropdownButton<String>(
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
    );
  }

  Widget _buildTipoRepuestoDropdown() {
    return Row(
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
    );
  }

  Widget _buildRepuestosList() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10, // Cambia esto según la cantidad de repuestos reales
        itemBuilder: (context, index) {
          return _buildRepuestoItem(index);
        },
      ),
    );
  }

  Widget _buildRepuestoItem(int index) {
    // Simulación de un elemento de repuesto
    return Card(
      child: ListTile(
        title: Text('Repuesto $index'),
        subtitle: Text('Descripción del Repuesto $index'),
        onTap: () {
          // Aquí puedes agregar la lógica para manejar el tap en un repuesto
        },
      ),
    );
  }

  void _onNavigationItemSelected(int index) {
    if (_selectedIndex != index) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0: // Repuestos
          // Lógica específica para la pantalla de "Repuestos"
          break;
        case 1: // Servicios
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ServiciosScreen()),
          );
          break;
        case 2: // Perfil
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PerfilScreen()),
          );
          break;
      }
    }
  }
}
