import 'package:evchargingpoint/view/auth/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 116, 195, 101),
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 116, 195, 101),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
