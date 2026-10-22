import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tienda')),
      body: const Center(
        child: Text('Pantalla de Tienda', style: TextStyle(fontSize: 24, color: AppColors.primaryBlue)),
      ),
    );
  }
}