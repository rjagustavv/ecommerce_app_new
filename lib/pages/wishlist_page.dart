import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/dummy_data.dart'; // Hanya untuk contoh wishlist

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  // Dummy wishlist items for demonstration
  static final List<Product> _wishlistItems = [
    dummyProducts[2],
    dummyProducts[4],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist Saya'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _wishlistItems.isEmpty
          ? const Center(
              child: Text(
                'Wishlist Anda kosong.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _wishlistItems.length,
              itemBuilder: (context, index) {
                final product = _wishlistItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: ListTile(
                    leading: Image.network(
                      product.imageUrl,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.name),
                    subtitle: Text('Rp ${product.price.toStringAsFixed(0)}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        // Implementasi hapus dari wishlist
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product.name} dihapus dari wishlist',
                            ),
                          ),
                        );
                      },
                    ),
                    onTap: () {
                      // Navigasi ke detail produk
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductDetailPage(product: product)));
                    },
                  ),
                );
              },
            ),
    );
  }
}
