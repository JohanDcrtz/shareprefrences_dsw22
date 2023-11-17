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

  TextEditingController nombreController = TextEditingController();
  TextEditingController telefonoController = TextEditingController();
  TextEditingController fechaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PRUEBA COMMIT'),
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
                'Detalles sobre Cambio de Aceite: Precio: \$39.99, Duración: 30 minutos',
              ),
              _buildServicioCard(
                'Reparación de Frenos',
                'Ofrecemos servicios de reparación y mantenimiento de sistemas de frenos.',
                Icons.stop_circle,
                'Detalles sobre Reparación de Frenos: Precio: \$89.99, Duración: 1 hora',
              ),
              _buildServicioCard(
                'Alineación y Balanceo',
                'Ajustamos la alineación y balanceo de las ruedas para un manejo suave.',
                Icons.format_line_spacing,
                'Detalles sobre Alineación y Balanceo: Precio: \$59.99, Duración: 45 minutos',
              ),
              _buildServicioCard(
                'Reparación de Motor',
                'Realizamos diagnósticos y reparaciones en el sistema del motor.',
                Icons.build,
                'Detalles sobre Reparación de Motor: Precio: \$129.99, Duración: 2 horas',
              ),
              SizedBox(height: 16.0),
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

  Widget _buildServicioCard(String title, String description, IconData icon, String detalles) {
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
                    _showDetallesDialog(context, detalles);
                  },
                  child: Text('Detalles'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _showCitaFormulario(context, title);
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
        ); // Navegar a la pantalla de Repuestos
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PerfilScreen()),
        );
        break;
    }
  }

  void _showDetallesDialog(BuildContext context, String detalles) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles del Servicio'),
          content: Text(detalles),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _showCitaFormulario(BuildContext context, String servicio) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Programar Cita para $servicio'),
          content: Column(
            children: [
              TextField(
                controller: nombreController,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              TextField(
                controller: telefonoController,
                decoration: InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
              ),
              TextField(
                controller: fechaController,
                decoration: InputDecoration(labelText: 'Fecha y Hora'),
                keyboardType: TextInputType.datetime,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Lógica para enviar la información de la cita
                // Puedes implementar la lógica según tus necesidades
                print('Cita programada para $servicio:');
                print('Nombre: ${nombreController.text}');
                print('Teléfono: ${telefonoController.text}');
                print('Fecha y Hora: ${fechaController.text}');
                Navigator.of(context).pop();
              },
              child: Text('Programar Cita'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
