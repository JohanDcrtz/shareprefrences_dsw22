import 'package:flutter/material.dart';
import 'package:shareprefrences_dsw22/screens/home.dart';
import 'package:shareprefrences_dsw22/screens/servicios_screen.dart';

class PerfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil del Taller'),
        automaticallyImplyLeading: false, // Oculta la flecha de retroceso
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTallerInfo(),
            SizedBox(height: 16.0),
            _buildContactInfo('Correo Electrónico', 'taller@tallerautomotriz.com'),
            SizedBox(height: 8.0),
            _buildContactInfo('Teléfono', '+1 234 567 890'),
            SizedBox(height: 16.0),
            _buildHorarioInfo(),
            SizedBox(height: 16.0),
            _buildSkills(),
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
        currentIndex: 2,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          _onNavigationItemSelected(context, index);
        },
      ),
    );
  }

  Widget _buildTallerInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 80,
          backgroundImage: AssetImage('assets/profile_picture.jpg'),
        ),
        SizedBox(height: 16.0),
        Text(
          'Nombre del Taller',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.0),
        Text(
          'Taller Especializado en Reparación de Vehículos',
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildContactInfo(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$label:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 8.0),
        Text(value),
      ],
    );
  }

  Widget _buildHorarioInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Horario de Atención',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text('Lunes a Viernes: 8:00 AM - 6:00 PM'),
        Text('Sábados: 9:00 AM - 1:00 PM'),
      ],
    );
  }

  Widget _buildSkills() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Servicios Ofrecidos',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          children: [
            _buildSkillChip('Reparación de Motores'),
            _buildSkillChip('Sistemas Eléctricos'),
            _buildSkillChip('Diagnóstico de Fallas'),
            _buildSkillChip('Mantenimiento Preventivo'),
            _buildSkillChip('Soldadura Automotriz'),
            _buildSkillChip('Suspensión y Dirección'),
            _buildSkillChip('Frenos y Embragues'),
          ],
        ),
      ],
    );
  }

  Widget _buildSkillChip(String skill) {
    return Chip(
      label: Text(skill),
      backgroundColor: Colors.blue,
      labelStyle: TextStyle(color: Colors.white),
    );
  }

  void _onNavigationItemSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ServiciosScreen()),
        );
        break;
      case 2:
        // Ya estamos en la pantalla de perfil, no es necesario hacer nada adicional.
        break;
    }
  }
}
