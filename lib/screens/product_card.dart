import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String image;

  ProductDetailScreen({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.blueAccent,
        elevation: 4.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Imagen del producto con esquinas redondeadas
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                image,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nombre del producto
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Precio del producto
                  Text(
                    '\$$price',
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Descripción del producto
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Botón para agregar al carrito con animación
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Mostrar animación de agregado al carrito
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('¡Producto agregado al carrito!'),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            });
                            return AlertDialog(
                              content: Row(
                                children: const [
                                  CircularProgressIndicator(),
                                  SizedBox(width: 16),
                                  Text("Agregando al carrito..."),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text('Agregar al Carrito'),
                      style: ElevatedButton.styleFrom(
                        
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
