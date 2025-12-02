import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geolocator/geolocator.dart'; // <-- TAMBAH INI


class QiblaPage extends StatefulWidget {
  const QiblaPage({super.key});

  @override
  State<QiblaPage> createState() => _QiblaPageState();
}

class _QiblaPageState extends State<QiblaPage> {
  final _qiblaStream = FlutterQiblah.qiblahStream;

  @override
  void initState() {
    super.initState();
    FlutterQiblah.requestPermissions(); // minta izin lokasi
  }

  @override
  Widget build(BuildContext context) {
    // cek dulu status lokasi (GPS + permission)
    return FutureBuilder<LocationStatus>(
      future: FlutterQiblah.checkLocationStatus(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final status = snapshot.data!;

        if (!status.enabled) {
          return const Center(
            child: Text(
              'Lokasi/GPS pada perangkat belum aktif.\n'
              'Aktifkan GPS lalu buka ulang aplikasi.',
              textAlign: TextAlign.center,
            ),
          );
        }

        if (status.status == LocationPermission.denied ||
            status.status == LocationPermission.deniedForever) {
          return const Center(
            child: Text(
              'Izin lokasi untuk aplikasi ini ditolak.\n'
              'Buka Pengaturan > Apps > [nama aplikasi] > Permissions\n'
              'Lalu set Location ke Allow.',
              textAlign: TextAlign.center,
            ),
          );
        }

        // kalau lokasi & izin OK, baru tampilkan kompas
        return Center(
          child: StreamBuilder<QiblahDirection>(
            stream: _qiblaStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(
                  'Terjadi error:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                );
              }

              if (!snapshot.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Mengambil arah kiblat...'),
                  ],
                );
              }

              final qiblahDirection = snapshot.data!;
              final angle =
                  -qiblahDirection.qiblah * (math.pi / 180); // derajat → radian

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Arah Kiblat: ${qiblahDirection.qiblah.toStringAsFixed(1)}°',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 220,
                    width: 220,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 220,
                          width: 220,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.green, width: 4),
                          ),
                        ),
                        Transform.rotate(
                          angle: angle,
                          child: const Icon(
                            Icons.navigation,
                            size: 160,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Putar ponsel hingga panah menghadap arah kiblat.\n'
                      'Pastikan sensor kompas dan GPS aktif.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
