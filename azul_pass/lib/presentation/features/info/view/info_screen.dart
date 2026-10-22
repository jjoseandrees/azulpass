import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Información')),
      body: const Center(
        child: Text('Pantalla de Información', style: TextStyle(fontSize: 24, color: AppColors.primaryBlue)),
      ),
    );
  }
}