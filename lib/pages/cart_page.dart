import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/dummy_data.dart'; // Hanya untuk contoh, idealnya dari state management

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class _CartPageState extends State<CartPage> {
  // Dummy cart items for demonstration
  List<CartItem> cartItems = [
    CartItem(product: dummyProducts[0], quantity: 1),
    CartItem(product: dummyProducts[1], quantity: 2),
  ];

  void _updateQuantity(CartItem item, int newQuantity) {
    setState(() {
      if (newQuantity > 0) {
        item.quantity = newQuantity;
      } else {
        cartItems.remove(item);
      }
    });
  }

  double get _totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        backgroundColor: Colors.deepPurple,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                'Keranjang Anda kosong.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 16,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Image.network(
                                item.product.imageUrl,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.product.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Rp ${item.product.price.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.remove_circle_outline,
                                          ),
                                          onPressed: () {
                                            _updateQuantity(
                                              item,
                                              item.quantity - 1,
                                            );
                                          },
                                        ),
                                        Text(item.quantity.toString()),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.add_circle_outline,
                                          ),
                                          onPressed: () {
                                            _updateQuantity(
                                              item,
                                              item.quantity + 1,
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Harga:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Rp ${_totalPrice.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Implementasi checkout
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Proses Checkout!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                          child: const Text('Checkout'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
