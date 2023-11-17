import 'package:flutter/material.dart';
import 'package:shareprefrences_dsw22/screens/home.dart';
import 'package:shareprefrences_dsw22/screens/perfil_screen.dart';


class ServiciosScreen extends StatefulWidget {
  @override
  _ServiciosScreenState createState() => _ServiciosScreenState();
}

class _ServiciosScreenState extends State<ServiciosScreen> {
  int _selectedIndex = 1; // Índice correspondiente a la pestaña de "Servicios"

  String selectedTipoServicio = 'Todos';
  List<String> tiposDeServicio = ['Todos', 'Mantenimiento', 'Reparación', 'Personalizado'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servicios en el Taller'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTipoServicioDropdown(),
              SizedBox(height: 16.0),
              _buildServicioCard(
                'Cambio de Aceite',
                'Realizamos cambios de aceite con productos de alta calidad.',
                Icons.local_car_wash,
              ),
              _buildServicioCard(
                'Reparación de Frenos',
                'Ofrecemos servicios de reparación y mantenimiento de sistemas de frenos.',
                Icons.stop_circle,
              ),
              _buildServicioCard(
                'Alineación y Balanceo',
                'Ajustamos la alineación y balanceo de las ruedas para un manejo suave.',
                Icons.format_line_spacing,
              ),
              _buildServicioCard(
                'Reparación de Motor',
                'Realizamos diagnósticos y reparaciones en el sistema del motor.',
                Icons.build,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Lógica para solicitar un servicio específico
                  // Puedes implementar la lógica según tus necesidades
                },
                child: Text('Solicitar Servicio'),
              ),
            ],
          ),
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

  Widget _buildTipoServicioDropdown() {
    return DropdownButton<String>(
      value: selectedTipoServicio,
      onChanged: (String? newValue) {
        setState(() {
          selectedTipoServicio = newValue!;
        });
      },
      items: tiposDeServicio
          .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          })
          .toList(),
    );
  }

  Widget _buildServicioCard(String title, String description, IconData icon) {
    return Card(
      elevation: 3.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  icon,
                  size: 40.0,
                  color: Colors.blue,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Lógica para ver más detalles del servicio
                    // Puedes implementar la lógica según tus necesidades
                  },
                  child: Text('Detalles'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para solicitar el servicio
                    // Puedes implementar la lógica según tus necesidades
                  },
                  child: Text('Solicitar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _onNavigationItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Implementa la lógica de navegación aquí según tus necesidades
    switch (_selectedIndex) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
       );// Navegar a la pantalla de Repuestos
        break;
      case 2:
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PerfilScreen()),
       );
        break;
    }
  }
}
