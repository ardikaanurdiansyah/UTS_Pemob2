  import 'package:flutter/material.dart';

class InfoListPage extends StatelessWidget {
  const InfoListPage({super.key});

  final List<Map<String, String>> _infos = const [
    {
      'title': 'Apa itu Kiblat?',
      'subtitle':
          'Kiblat adalah arah Ka\'bah di Masjidil Haram yang menjadi arah shalat umat Islam.'
    },
    {
      'title': 'Kenapa arah penting?',
      'subtitle':
          'Menghadap kiblat merupakan salah satu syarat sah shalat, kecuali pada kondisi tertentu.'
    },
    {
      'title': 'Gunakan kompas dengan tenang',
      'subtitle':
          'Jauhkan ponsel dari logam besar atau magnet agar arah lebih akurat.'
    },
    {
      'title': 'Cek lokasi',
      'subtitle':
          'Aktifkan GPS agar aplikasi dapat menentukan arah kiblat dari posisi kamu sekarang.'
    },
    {
      'title': 'Kalibrasi sensor',
      'subtitle':
          'Bila arah terasa tidak akurat, gerakkan ponsel membentuk angka 8 untuk kalibrasi.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _infos.length,
      itemBuilder: (context, index) {
        final item = _infos[index];
        return Card(
          elevation: 2,
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Icons.lightbulb),
            title: Text(item['title']!),
            subtitle: Text(item['subtitle']!),
          ),
        );
      },
    );
  }
}
