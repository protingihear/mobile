import 'package:flutter/material.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.only(left: 10),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFA3D6A7),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildNewsItem(
              imageUrl: 'https://via.placeholder.com/120x90',
              date: 'Jumat, 22 Nov 2024 19:30 WIB',
              title:
                  'Finalis Tuli Pertama Miss Universe Mundur, Penyakitnya Bikin Tak Kuat Berdiri',
              description:
                  'Mia le Roux, finalis tuli pertama Miss Universe 2024, mundur karena masalah kesehatan. Dia menderita penyakit ini yang mengganggu aktivitasnya.',
            ),
            _buildNewsItem(
              imageUrl: 'https://via.placeholder.com/120x90',
              date: 'Senin, 11 Nov 2024 18:05 WIB',
              title:
                  'Senangnya Tunarungu Pacitan Terima Alat Bantu Dengar dari Bhayangkari',
              description:
                  'Sukiran dan Novi, penyandang tunarungu di Pacitan, kini dapat berkomunikasi lebih baik. Ini berkat alat bantu dengar bantuan dari Bhayangkari Pacitan.',
            ),
            _buildNewsItem(
              imageUrl: 'https://via.placeholder.com/120x90',
              date: 'Senin, 29 Jul 2024 14:35 WIB',
              title:
                  'Pemohon SIM Tunarungu di Kota Kediri Didampingi Juru Bahasa Isyarat',
              description:
                  'Para penyandang disabilitas yang mengurus SIM A dan SIM C di Kota Kediri, didampingi penerjemah atau juru bahasa isyarat. Ini mempermudah pembuatan.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsItem({
    required String imageUrl,
    required String date,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 120,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$date',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
