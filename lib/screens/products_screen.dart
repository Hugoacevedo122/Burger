 import 'package:flutter/material.dart';



class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final List<Map<String, String>> products = [
    {
      'name': 'Hamburguesa',
      'price': '\$5.99',
      'description': 'Deliciosa hamburguesa con carne jugosa y queso derretido.',
      'image': 'assets/images/burger.png',
    },
    {
      'name': 'Pizza',
      'price': '\$8.99',
      'description': 'Pizza con ingredientes frescos y masa crujiente.',
      'image': 'assets/images/pizza.png',
    },
    {
      'name': 'Hot Dog',
      'price': '\$3.99',
      'description': 'Sencillo y delicioso hot dog con salsa especial.',
      'image': 'assets/images/hotdog.png',
    },
    {
      'name': 'Papas Fritas',
      'price': '\$2.99',
      'description': 'Papas fritas crujientes acompañadas de salsa.',
      'image': 'assets/images/fries.png',
    },
  ];

  final List<Map<String, String>> cart = [];
  GlobalKey<ScaffoldMessengerState> scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  void addToCart(Map<String, String> product) {
    setState(() {
      cart.add(product);
    });

    // Mostrar animación o mensaje
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(content: Text('${product['name']} agregado al carrito')),
    );
  }

  void navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(cart: cart),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Nuestros Productos'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: navigateToCart,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Anuncio de promoción
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              color: const Color.fromARGB(255, 0, 0, 0),
              child: Column(
                children: [
                  Text(
                    '¡Oferta Especial!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Compra 2 productos y recibe un descuento del 20%',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Lista de productos en 2 columnas
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _showProductDetail(context, products[index]),
                    child: ProductCard(
                      name: products[index]['name']!,
                      price: products[index]['price']!,
                      image: products[index]['image']!,
                      onAddToCart: () => addToCart(products[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductDetail(BuildContext context, Map<String, String> product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProductDetailScreen(product: product),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String image;
  final VoidCallback onAddToCart;

  const ProductCard({
    required this.name,
    required this.price,
    required this.image,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onAddToCart,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              height: 120,
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                price,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: onAddToCart,
              child: Text('Agregar al carrito'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Map<String, String> product;

  const ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text(product['name']!),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              product['image']!,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                product['description']!,
                style: TextStyle(fontSize: 18),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Lógica para agregar al carrito
                Navigator.pop(context);
              },
              child: Text('Agregar al carrito'),
            ),
          ],
        ),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  final List<Map<String, String>> cart;

  CartScreen({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text('Carrito de Compras'),
        centerTitle: true,
      ),
      body: cart.isEmpty
          ? Center(
              child: Text(
                'El carrito está vacío',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final product = cart[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Image.asset(
                      product['image']!,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product['name']!),
                    subtitle: Text(product['description']!),
                    trailing: Text(product['price']!),
                  ),
                );
              },
            ),
    );
  }
} 