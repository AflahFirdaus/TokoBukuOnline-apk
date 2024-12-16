import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data Dummy untuk Pengaturan
    final List<Map<String, dynamic>> settingsData = [
      {
        'icon': Icons.account_circle,
        'title': 'Akun',
        'subtitle': 'Kelola informasi akun Anda',
      },
      {
        'icon': Icons.notifications,
        'title': 'Notifikasi',
        'subtitle': 'Atur preferensi notifikasi',
      },
      {
        'icon': Icons.lock,
        'title': 'Privasi',
        'subtitle': 'Pengaturan privasi dan keamanan',
      },
      {
        'icon': Icons.language,
        'title': 'Bahasa',
        'subtitle': 'Pilih bahasa aplikasi',
      },
      {
        'icon': Icons.help,
        'title': 'Bantuan',
        'subtitle': 'Pusat bantuan dan dukungan',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: settingsData.length,
        itemBuilder: (context, index) {
          final item = settingsData[index];
          return ListTile(
            leading: Icon(
              item['icon'],
              color: Colors.blue,
            ),
            title: Text(
              item['title'],
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(item['subtitle']),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Tambahkan navigasi atau aksi sesuai kebutuhan
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Navigasi ke ${item['title']}')),
              );
            },
          );
        },
      ),
    );
  }
}
