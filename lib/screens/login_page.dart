// lib/views/login_page.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shareprefrences_dsw22/screens/inventario_screen.dart';
import 'package:shareprefrences_dsw22/views/sign_up_auth.dart';
import 'package:shareprefrences_dsw22/widget/input_widget.dart';
import '../user_auth/firebase_auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? mensaje;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 30),
              _InputCustomized(
                _emailController,
                false,
                'Correo electrónico',
                'E-mail',
                TextInputType.emailAddress,
                Icons.email,
              ),
              const SizedBox(height: 30),
              InputWidget(
                controller: _passwordController,
                hintText: 'Contraseña',
                isPasswordField: true,
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: _signIn,
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("¿No tienes una cuenta?"),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpPage()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      "Registrarme",
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Text(
                '$mensaje',
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    String email = _emailController.text;
    String password = _passwordController.text;
    User? user = await _auth.signInWithEmailAndPassword(email, password);
    if (user != null) {
      print("Login Satisfactorio!!!");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InventarioScreen()),
      );
      setState(() {
        mensaje = "";
      });
    } else {
      setState(() {
        mensaje = "No se encontró el usuario especificado";
      });
    }
  }

  Widget _InputCustomized(
    TextEditingController? controller,
    bool? isPassword,
    String? hintText,
    String? labelText,
    TextInputType? inputType,
    IconData? icon,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        style: TextStyle(color: Colors.black),
        controller: controller,
        keyboardType: inputType,
        obscureText: isPassword == true ? true : false,
        decoration: InputDecoration(
          border: InputBorder.none,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black45,
          ),
          suffixIcon: Icon(
            icon,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
