import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_register_screen.dart';
import 'screens/products_screen.dart';

void main() {
  runApp(FastFoodApp());
}

class FastFoodApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,  // Desactiva el banner de debug
      title: 'Fast Food App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/login': (context) => LoginRegisterScreen(),
        '/products': (context) => ProductsScreen(),
      },
    );
  }
}


