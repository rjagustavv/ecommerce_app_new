import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/dummy_data.dart'; // Hanya untuk contoh dummy data

class Order {
  final String id;
  final DateTime orderDate;
  final double totalAmount;
  final List<Product> items;
  final String status;

  Order({
    required this.id,
    required this.orderDate,
    required this.totalAmount,
    required this.items,
    required this.status,
  });
}

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  // Dummy order history
  static final List<Order> _dummyOrders = [
    Order(
      id: 'ORD001',
      orderDate: DateTime(2023, 10, 20),
      totalAmount: 450000,
      items: [dummyProducts[0]],
      status: 'Selesai',
    ),
    Order(
      id: 'ORD002',
      orderDate: DateTime(2023, 11, 01),
      totalAmount: 240000,
      items: [dummyProducts[1], dummyProducts[1]], // 2 Kaos
      status: 'Diproses',
    ),
    Order(
      id: 'ORD003',
      orderDate: DateTime(2023, 11, 15),
      totalAmount: 380000 + 600000,
      items: [dummyProducts[2], dummyProducts[4]],
      status: 'Dikirim',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        backgroundColor: Colors.deepPurple,
      ),
      body: _dummyOrders.isEmpty
          ? const Center(
              child: Text(
                'Anda belum memiliki riwayat pesanan.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: _dummyOrders.length,
              itemBuilder: (context, index) {
                final order = _dummyOrders[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  elevation: 2,
                  child: ExpansionTile(
                    title: Text('Pesanan #${order.id}'),
                    subtitle: Text(
                      'Tanggal: ${order.orderDate.toLocal().toString().split(' ')[0]} - Total: Rp ${order.totalAmount.toStringAsFixed(0)}',
                    ),
                    trailing: Chip(
                      label: Text(order.status),
                      backgroundColor: order.status == 'Selesai'
                          ? Colors.green.shade100
                          : Colors.orange.shade100,
                    ),
                    children: order.items.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 4.0,
                        ),
                        child: Row(
                          children: [
                            Image.network(
                              item.imageUrl,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text('Rp ${item.price.toStringAsFixed(0)}'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
    );
  }
}
