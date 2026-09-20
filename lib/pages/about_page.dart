import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';
import '../theme/app_theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'About',
        subtitle: 'Informasi aplikasi',
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: AppTheme.appBarGradient,
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(Icons.photo_camera_rounded,
                  color: Colors.white, size: 48),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Photo Gallery Camera',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 4),
          Center(
            child: Text(
              'Versi 1.0.0',
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
          ),
          const SizedBox(height: 24),
          _sectionCard(
            context: context,
            title: 'Deskripsi Aplikasi',
            child: const Text(
              'Photo Gallery Camera adalah aplikasi galeri foto modern yang '
              'memungkinkan pengguna menjelajahi foto dari internet, menyimpan '
              'foto favorit, mengambil foto langsung melalui kamera perangkat, '
              'dan mengunggah foto ke server. Aplikasi ini dibuat sebagai tugas UAS '
              'kuliah untuk mendemonstrasikan konsep Routing, Network Fetching, '
              'Sensor Kamera, dan State Management dengan Cubit.',
              style: TextStyle(height: 1.5),
            ),
          ),
          const SizedBox(height: 16),
          _sectionCard(
            context: context,
            title: 'Informasi Mahasiswa',
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoRow(label: 'Nama', value: 'I Putu Arya Dipta Yudistira'),
                _InfoRow(label: 'NIM', value: '2455011002'),
                _InfoRow(
                    label: 'Mata Kuliah',
                    value: 'Pemrograman Mobile'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _sectionCard(
            context: context,
            title: 'Teknologi yang Digunakan',
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                _TechChip(label: 'Flutter'),
                _TechChip(label: 'Material 3'),
                _TechChip(label: 'flutter_bloc (Cubit)'),
                _TechChip(label: 'Dio'),
                _TechChip(label: 'go_router'),
                _TechChip(label: 'image_picker'),
                _TechChip(label: 'shimmer'),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _sectionCard({
    required BuildContext context,
    required String title,
    required Widget child,
  }) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child:
                Text(label, style: TextStyle(color: scheme.onSurfaceVariant)),
          ),
          const Text(': '),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _TechChip extends StatelessWidget {
  final String label;

  const _TechChip({required this.label});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: scheme.primary,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
