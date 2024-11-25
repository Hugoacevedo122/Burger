import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation1;
  late Animation<double> _textAnimation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 3), // Duración total de la animación
      vsync: this,
    );

    // Animación para el logo (comienza grande y se reduce)
    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    // Animación para el primer texto (Bienvenido)
    _textAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.3, 0.6, curve: Curves.easeInOut)),
    );

    // Animación para el segundo texto (Descripción)
    _textAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.6, 1.0, curve: Curves.easeInOut)),
    );

    _controller.forward(); // Inicia las animaciones
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0), // Fondo oscuro
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo con animación de escala
              ScaleTransition(
                scale: _logoAnimation,
                child: Image.asset(
                  'assets/images/logo.png', // Ruta del logo
                  width: 150,  // Tamaño del logo
                  height: 150, // Tamaño del logo
                ),
              ),
              SizedBox(height: 30),

              // Título de la bienvenida con animación de opacidad
              FadeTransition(
                opacity: _textAnimation1,
                child: Text(
                  '¡Bienvenido a Burger Haven!',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Roboto',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),

              // Descripción o mensaje corto con animación de opacidad
              FadeTransition(
                opacity: _textAnimation2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    'Disfruta de las mejores opciones de comida rápida, ¡pedir nunca fue tan fácil!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontFamily: 'Roboto',
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 40),

              // Botón de inicio
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text('Comenzar'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
