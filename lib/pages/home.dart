import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(title: 'My App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _textController = TextEditingController();
  String _storedValue = "";
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    setState(() {
      _isLoggedIn = isLoggedIn;
      if (_isLoggedIn) {
        _loadStoredValue();
      }
    });
  }

  Future<void> _loadStoredValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedValue = prefs.getString('storedValue') ?? "";
    });
  }

  Future<void> _saveValue() async {
    final prefs = await SharedPreferences.getInstance();
    final newValue = _textController.text;
    prefs.setString('storedValue', newValue);

    setState(() {
      _storedValue = newValue;
    });

    // Guardar el nuevo valor en Firestore
    await saveValueInFirestore(newValue);
  }

  Future<void> saveValueInFirestore(String value) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("tb_valores");
    await collectionReference.add({
      'valor': value,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', false);
    prefs.remove('storedValue');
    setState(() {
      _isLoggedIn = false;
      _storedValue = "";
    });
  }

  void _login() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    setState(() {
      _isLoggedIn = true;
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_isLoggedIn)
                Column(
                  children: <Widget>[
                    Text(
                      'Valor almacenado en SharedPreferences:',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      _storedValue,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        labelText: 'Introduce un valor',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _saveValue,
                      child: Text('Guardar valor'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _logout,
                      child: Text('Cerrar Sesión'),
                    ),
                  ],
                )
              else
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Iniciar Sesión'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
