import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Tentang Aplikasi',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Aplikasi Petunjuk Arah Kiblat ini dibuat untuk membantu '
            'pengguna menemukan arah kiblat secara mudah menggunakan sensor '
            'dan lokasi pada smartphone.',
            textAlign: TextAlign.justify,
          ),
          SizedBox(height: 24),
          Text('Nama Aplikasi : Petunjuk Arah Kiblat'),
          Text('Versi         : 1.0.0'),
          SizedBox(height: 24),
          Text(
            'Copyright by ArdikaNurdiansyah_23552011311',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
