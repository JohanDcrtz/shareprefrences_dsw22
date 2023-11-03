import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shareprefrences_dsw22/firebase_options.dart';
import 'package:shareprefrences_dsw22/pages/home.dart';
import 'package:shareprefrences_dsw22/views/login_page.dart';
import 'package:shareprefrences_dsw22/views/sign_up_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: "/login",
      routes: {

        "/login":(context) => const LoginPage(),
        "/signup":(context) => const SignUpPage(),
        

      },
      home: MyHomePage(title: 'Mi expo Johan'),
    );
  }
}
