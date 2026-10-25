import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/widgets/quick_access_card.dart';
import '../../../../core/theme/app_colors.dart';
import '../../matches/viewmodel/matches_viewmodel.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final matchesAsync = ref.watch(matchesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'AzulPass',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notificaciones en desarrollo')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBanner(context),
            const SizedBox(height: 24),
            const Text('Accesos rápidos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),),
            const SizedBox(height: 12),
            _buildQuickAccessGrid(context),
            const SizedBox(height: 24),

            const Text('Próximo partido', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textPrimary),),
            const SizedBox(height: 12),

            matchesAsync.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: CircularProgressIndicator(color: AppColors.primaryBlue,),
                ),
              ),
              error: (err, _) => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(12)),
                child: Text('Error al cargar próximos partidos: $err', style: const TextStyle(color: AppColors.error)),
              ),
              data: (matches){
                if (matches.isEmpty){
                  return const _EmptyMatchesCard();
                }
                return _buildNextMatchCard(context, matches.first);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryBlue, AppColors.secondaryBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '¡Vive la pasión de la U!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Compra tus entradas de forma segura y rápida',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.go('/partidos'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primaryBlue,
            ),
            child: const Text('Ver partidos'),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        QuickAccessCard(
          title: 'Comprar entradas',
          icon: Icons.confirmation_number,
          onTap: () => context.go('/partidos'),
        ),
        QuickAccessCard(
          title: 'Mis entradas',
          icon: Icons.qr_code,
          onTap: () => context.go('/entradas'),
        ),
        QuickAccessCard(
          title: 'Info estadio',
          icon: Icons.stadium,
          onTap: () => context.go('/info'),
        ),
        QuickAccessCard(
          title: 'Antes de ir',
          icon: Icons.checklist,
          onTap: () {
          },
        ),
      ],
    );
  }

  // Cambia la firma para recibir el MatchEntity
  Widget _buildNextMatchCard(BuildContext context, dynamic match) {
    // Formateamos la fecha de forma elegante
    final dateStr = '${match.matchDate.day} Oct ${match.matchDate.year} - ${match.matchDate.hour.toString().padLeft(2, '0')}:${match.matchDate.minute.toString().padLeft(2, '0')}';

    return GestureDetector(
      onTap: () => context.go('/partidos/${match.id}'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.sports_soccer, color: AppColors.primaryBlue, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${match.homeTeam} vs ${match.awayTeam}',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dateStr,
                    style: const TextStyle(fontSize: 14, color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.primaryBlue),
          ],
        ),
      ),
    );
  }
}

class _EmptyMatchesCard extends StatelessWidget {
  const _EmptyMatchesCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
      child: const Row(
        children: [
          Icon(Icons.calendar_today, color: AppColors.textSecondary),
          SizedBox(width: 12),
          Text('No hay partidos programados por ahora.', style: TextStyle(color: AppColors.textSecondary)),
          ],
        ),
      );
    }
  }