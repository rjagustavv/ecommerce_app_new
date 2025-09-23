import 'package:flutter/material.dart';
import 'order_history.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.deepPurple.shade50,
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150/CCCCCC/000000?text=Avatar',
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Raja Gustav',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'rjagustavv@gmail.com',
                    style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('Edit Profil'),
              onTap: () {
                // Navigasi ke Edit Profile
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Halaman Edit Profil')),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('Riwayat Pesanan'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OrderHistoryPage(),
                  ),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Pengaturan'),
              onTap: () {
                // Navigasi ke Pengaturan
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Halaman Pengaturan')),
                );
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout', style: TextStyle(color: Colors.red)),
              onTap: () {
                // Implementasi Logout
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Anda telah logout')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
