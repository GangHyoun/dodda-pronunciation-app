import 'package:ddd_02/01_LoginPages/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
	// 반드시 WidgetsFlutterBinding.ensureInitialized() 다음에 추가해야 한다.
	await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const  MaterialApp(
      home: LoginPage(),
    );
  }
}
