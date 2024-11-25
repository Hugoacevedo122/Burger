import 'package:flutter/material.dart';

class LoginRegisterScreen extends StatefulWidget {
  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  bool isLogin = true;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.login,
              color: Colors.white,
            ),
            SizedBox(width: 8),
            Text(
              isLogin ? 'Iniciar Sesión' : 'Registrarse',
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icono grande de una persona con borde y fondo llamativo
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // Sombra
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.person,
                        size: 120,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Título con mensaje
                    Text(
                      isLogin ? '¡Bienvenido de nuevo!' : 'Crea una cuenta',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Letras negras
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),

                    // Animación de campos de entrada
                    AnimatedContainer(
                      duration: Duration(seconds: 1),
                      curve: Curves.easeInOut,
                      child: Column(
                        children: [
                          // Campo de nombre (solo para registro)
                          if (!isLogin)
                            TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                labelText: 'Nombre Completo',
                                labelStyle: TextStyle(color: Colors.black),
                                prefixIcon: Icon(Icons.person, color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor ingresa tu nombre completo';
                                }
                                return null;
                              },
                            ),
                          SizedBox(height: 20),

                          // Campo de teléfono (solo para registro)
                          if (!isLogin)
                            TextFormField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Número de Teléfono',
                                labelStyle: TextStyle(color: Colors.black),
                                prefixIcon: Icon(Icons.phone, color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor ingresa tu número de teléfono';
                                }
                                if (value.length < 10) {
                                  return 'Por favor ingresa un número válido';
                                }
                                return null;
                              },
                            ),
                          SizedBox(height: 20),

                          // Campo de correo electrónico
                          TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: 'Correo Electrónico',
                              labelStyle: TextStyle(color: Colors.black),
                              prefixIcon: Icon(Icons.email, color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa un correo electrónico';
                              }
                              String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                              RegExp regex = RegExp(pattern);
                              if (!regex.hasMatch(value)) {
                                return 'Por favor ingresa un correo electrónico válido';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Campo de contraseña
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              labelStyle: TextStyle(color: Colors.black),
                              prefixIcon: Icon(Icons.lock, color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Por favor ingresa una contraseña';
                              }
                              if (value.length < 8) {
                                return 'La contraseña debe tener al menos 8 caracteres';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),

                          // Campo de confirmación de contraseña (solo para registro)
                          if (!isLogin)
                            TextFormField(
                              controller: _confirmPasswordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Confirmar Contraseña',
                                labelStyle: TextStyle(color: Colors.black),
                                prefixIcon: Icon(Icons.lock, color: Colors.black),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor confirma tu contraseña';
                                }
                                if (value != _passwordController.text) {
                                  return 'Las contraseñas no coinciden';
                                }
                                return null;
                              },
                            ),
                          SizedBox(height: 30),

                          // Botón de acción (Iniciar sesión / Registrarse)
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushNamed(context, '/products');
                              }
                            },
                            child: Text(isLogin ? 'Iniciar Sesión' : 'Registrarse'),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 20),

                          // Enlace para cambiar entre iniciar sesión y registrarse
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                            child: Text(
                              isLogin
                                  ? '¿No tienes cuenta? Regístrate aquí'
                                  : '¿Ya tienes cuenta? Inicia sesión',
                              style: TextStyle(color: Colors.lightBlueAccent, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
