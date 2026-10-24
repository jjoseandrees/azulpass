import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../shared/widgets/primary_button.dart';
import '../viewmodel/sector_selection_providers.dart';
import '../../matches/viewmodel/match_detail_viewmodel.dart'; // Importamos el provider para obtener los detalles del partido
import '../../../../domain/entities/sector_entity.dart';

class SectorSelectionScreen extends ConsumerWidget {
  final String matchId;
  const SectorSelectionScreen({super.key, required this.matchId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final matchAsync = ref.watch(matchDetailProvider(matchId));
    final selectedSector = ref.watch(selectedSectorProvider);
    final quantity = ref.watch(ticketQuantityProvider);
    final totalPrice = ref.watch(totalPriceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Elige tu sector'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(), // Vuelve a la ficha del partido
        ),
      ),
      body: matchAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
        data: (match) => Column(
          children: [
            // Lista de sectores
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: match.availableSectors.length,
                itemBuilder: (context, index) {
                  final sector = match.availableSectors[index];
                  final isSelected = selectedSector?.id == sector.id;
                  
                  return _SectorCard(
                    sector: sector,
                    isSelected: isSelected,
                    onTap: () {
                      // Actualizamos el estado global de Riverpod
                      ref.read(selectedSectorProvider.notifier).state = sector;
                    },
                  );
                },
              ),
            ),
            
            // Resumen y botón de continuar (Fijo en la parte inferior)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha:0.1), blurRadius: 10, offset: const Offset(0, -5)),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Selector de cantidad
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Cantidad de entradas:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            color: quantity > 1 ? AppColors.primaryBlue : Colors.grey,
                            onPressed: quantity > 1 
                              ? () => ref.read(ticketQuantityProvider.notifier).state-- 
                              : null,
                          ),
                          Text('$quantity', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            color: AppColors.primaryBlue,
                            // Regla de negocio: Máximo 4 entradas por compra (ejemplo)
                            onPressed: quantity < 4 
                              ? () => ref.read(ticketQuantityProvider.notifier).state++ 
                              : null,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Precio total
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total a pagar:', style: TextStyle(fontSize: 16, color: AppColors.textSecondary)),
                      Text(
                        '\$${totalPrice.toStringAsFixed(0)}', 
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Botón de continuar
                  PrimaryButton(
                    label: 'Continuar',
                    icon: Icons.arrow_forward,
                    onPressed: selectedSector != null 
                      ? () => context.push('/partidos/$matchId/datos') // Próximo paso
                      : null, // Se deshabilita si no hay sector seleccionado
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget privado para la tarjeta de sector (sector card)
class _SectorCard extends StatelessWidget {
  final SectorEntity sector;
  final bool isSelected;
  final VoidCallback onTap;

  const _SectorCard({
    required this.sector,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: sector.isAvailable ? onTap : null,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue.withValues(alpha: 0.1) : AppColors.surface,
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Opacity(
          opacity: sector.isAvailable ? 1.0 : 0.5,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sector.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppColors.primaryBlue : AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${sector.price.toStringAsFixed(0)} c/u',
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
              if (!sector.isAvailable)
                const Chip(
                  label: Text('Agotado', style: TextStyle(fontSize: 10)),
                  backgroundColor: AppColors.error,
                  labelStyle: TextStyle(color: Colors.white),
                )
              else if (isSelected)
                const Icon(Icons.check_circle, color: AppColors.primaryBlue, size: 28)
              else
                const Icon(Icons.radio_button_unchecked, color: Colors.grey, size: 28),
            ],
          ),
        ),
      ),
    );
  }
}