import 'package:azul_pass/domain/entities/match_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../viewmodel/match_detail_viewmodel.dart';

class MatchDetailScreen extends ConsumerWidget {
  final String matchId;
  const MatchDetailScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchAsync = ref.watch(matchDetailProvider(matchId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ficha del Partido'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/partidos'), // Usamos go para volver a la lista sin apilar
        ),
      ),
      body: matchAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (match) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Encabezado del partido
              _buildMatchHeader(match),
              const SizedBox(height: 24),
              
              // Información clave
              _buildInfoSection('Estadio', match.stadium, Icons.stadium),
              const SizedBox(height: 12),
              _buildInfoSection('Competencia', match.competition, Icons.emoji_events),
              const SizedBox(height: 12),
              _buildInfoSection(
                'Fecha y Hora', 
                '${match.matchDate.day}/${match.matchDate.month}/${match.matchDate.year} - ${match.matchDate.hour}:${match.matchDate.minute.toString().padLeft(2, '0')}', 
                Icons.calendar_today
              ),
              
              const SizedBox(height: 24),
              
              // Fases de venta
              const Text('Fases de Venta', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...match.salePhases.map((phase) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    const Icon(Icons.schedule, size: 16, color: AppColors.primaryBlue),
                    const SizedBox(width: 8),
                    Expanded(child: Text(phase)),
                  ],
                ),
              )),

              const SizedBox(height: 24),

              // Requisitos (Muy importante)
              const Text('Requisitos de Ingreso', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.warning.withValues(alpha: 0.5)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: match.requirements.map((req) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
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
              ),

              const SizedBox(height: 32),

              // Botón de acción
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navegamos al siguiente paso del flujo
                    context.push('/partidos/${match.id}/sector');
                  },
                  icon: const Icon(Icons.confirmation_number),
                  label: const Text('Comprar Entradas', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatchHeader(MatchEntity match) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.primaryBlue, AppColors.secondaryBlue]),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text('${match.homeTeam} vs ${match.awayTeam}', 
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              match.competition,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                ),
            )
          )
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primaryBlue),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        )
      ],
    );
  }
}