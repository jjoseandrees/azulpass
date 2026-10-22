import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tickets')),
      body: const Center(
        child: Text('Pantalla de Tickets', style: TextStyle(fontSize: 24, color: AppColors.primaryBlue)),
      ),
    );
  }
}