import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/matches_viewmodel.dart';
import '../../../../core/theme/app_colors.dart';

class MatchesScreen extends ConsumerWidget {
  const MatchesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Escuchamos el provider. Riverpod nos devuelve un objeto "AsyncValue"
    // que puede estar en estado: loading, data, o error.
    final matchesAsync = ref.watch(matchesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Próximos Partidos'),
      ),
      body: matchesAsync.when(
        // Estado: Cargando (mientras el Mock hace el delay de 1 segundo)
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.primaryBlue),
        ),
        
        // Estado: Error
        error: (error, stack) => Center(
          child: Text('Error al cargar partidos: $error'),
        ),
        
        // Estado: Éxito (Tenemos los datos)
        data: (matches) {
          if (matches.isEmpty) {
            return const Center(child: Text('No hay partidos próximos'));
          }
          
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: matches.length,
            itemBuilder: (context, index) {
              final match = matches[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  leading: const Icon(Icons.sports_soccer, color: AppColors.primaryBlue, size: 32),
                  title: Text(
                    '${match.homeTeam} vs ${match.awayTeam}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(match.competition),
                      Text('${match.stadium} - ${match.matchDate.day}/${match.matchDate.month}/${match.matchDate.year}'),
                    ],
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Aquí podrías navegar a una pantalla de detalles del partido
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}