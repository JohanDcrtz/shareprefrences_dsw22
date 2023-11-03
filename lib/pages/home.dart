import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();
    _loadStoredValue();
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

    // Guardar el nuevo valor en Firestore
    await saveValueInFirestore(newValue);

    _loadStoredValue(); // Actualiza el estado con el nuevo valor.
  }

  Future<void> saveValueInFirestore(String value) async {
    CollectionReference collectionReference = FirebaseFirestore.instance.collection("tb_valores");
    await collectionReference.add({
      'valor': value,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
