import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final String name;
  final String description;
  final String price;
  final String image;

  // Lista de reseñas iniciales
  final List<Map<String, String>> reviews = [
    {'user': 'Juan', 'comment': '¡Delicioso! Me encantó el sabor.'},
    {'user': 'María', 'comment': 'Buena calidad, pero llegó un poco tarde.'},
    {'user': 'Carlos', 'comment': 'Excelente servicio y muy rico.'},
  ];

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
        backgroundColor: Colors.blueAccent,
        title: Text(name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen del producto
            Image.asset(
              image,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),

            // Nombre del producto
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Precio del producto
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '\$${price}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Descripción del producto
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Título de Reseñas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                'Reseñas',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Lista de reseñas
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: reviews
                    .map(
                      (review) => Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            review['user']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(review['comment']!),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),

            // Espacio al final
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
