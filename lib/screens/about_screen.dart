import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Tentang Aplikasi'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Image.asset('images/logo uncut.png', height: 100),

                    Text(
                      'POSMAR (Posyandu Maharani)',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Aplikasi Digital Posyandu Maharani',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.green.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Deskripsi
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.withValues(alpha: 0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  'POSMAR (Posyandu Maharani) adalah aplikasi digital yang dibuat untuk membantu kegiatan administrasi dan pendataan di Posyandu Maharani, Kelurahan Maharani.\n\n'
                  'Aplikasi ini dikembangkan oleh tim KKN MBKM Universitas Riau Kelurahan Maharani Tahun 2025, dan dikembangkan lebih lanjut oleh Syahid Al Baddry.\n\n'
                  'Tujuan utama dari pembuatan aplikasi POSMAR adalah untuk mempermudah kader Posyandu dalam melakukan pendataan warga, ibu hamil, dan balita, sehingga kegiatan Posyandu dapat berjalan lebih efektif, efisien, dan terdata dengan baik secara digital.\n\n'
                  'Aplikasi POSMAR dibuat pada 3 November 2025, sebagai salah satu bentuk kontribusi mahasiswa KKN MBKM UNRI dalam mendukung transformasi digital pelayanan masyarakat di bidang kesehatan.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Footer / credit
              Text(
                '© 2025 KKN MBKM Universitas Riau\nDikembangkan oleh Syahid Albadry',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.green.shade700,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
