import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../viewmodel/info_viewmodel.dart';
import '../../../../domain/entities/faq_entity.dart';

class InfoScreen extends ConsumerWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stadiumAsync = ref.watch(stadiumInfoProvider);
    final faqsAsync = ref.watch(faqsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Información'),
      ),
      body: stadiumAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primaryBlue)),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (stadium) => faqsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primaryBlue)),
          error: (err, _) => Center(child: Text('Error: $err')),
          data: (faqs) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSection('Cómo llegar', Icons.directions, _buildHowToGet(stadium)),
              const SizedBox(height: 24),
              _buildSection('Estacionamientos', Icons.local_parking, _buildParking(stadium)),
              const SizedBox(height: 24),
              _buildSection('Requisitos de ingreso', Icons.checklist, _buildRequirements(stadium)),
              const SizedBox(height: 24),
              _buildSection('Preguntas frecuentes', Icons.help_outline, _buildFAQs(faqs)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, IconData icon, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: AppColors.primaryBlue, size: 24),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
            ),
          ],
        ),
        const SizedBox(height: 12),
        content,
      ],
    );
  }

  Widget _buildHowToGet(dynamic stadium) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryBlue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            stadium.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 4),
          Text(stadium.address, style: const TextStyle(color: AppColors.textSecondary)),
          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 8),
          const Text('Opciones de transporte:', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          ...stadium.transportOptions.map<Widget>((option) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle, size: 16, color: AppColors.success),
                const SizedBox(width: 8),
                Expanded(child: Text(option)),
              ],
            ),
          )),
        ],
      ),
    );
  }

  Widget _buildParking(dynamic stadium) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: stadium.parkingInfo.map<Widget>((info) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline, size: 16, color: AppColors.primaryBlue),
              const SizedBox(width: 8),
              Expanded(child: Text(info)),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildRequirements(dynamic stadium) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: stadium.entryRequirements.map<Widget>((req) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber_rounded, size: 16, color: AppColors.warning),
              const SizedBox(width: 8),
              Expanded(child: Text(req)),
            ],
          ),
        )).toList(),
      ),
    );
  }

  Widget _buildFAQs(List<FaqEntity> faqs) {
    return Column(
      children: faqs.map((faq) => _FAQCard(faq: faq)).toList(),
    );
  }
}

class _FAQCard extends StatefulWidget {
  final FaqEntity faq;
  const _FAQCard({required this.faq});

  @override
  State<_FAQCard> createState() => _FAQCardState();
}

class _FAQCardState extends State<_FAQCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              widget.faq.question,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            trailing: Icon(_isExpanded ? Icons.expand_less : Icons.expand_more),
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(
                widget.faq.answer,
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            ),
        ],
      ),
    );
  }
}