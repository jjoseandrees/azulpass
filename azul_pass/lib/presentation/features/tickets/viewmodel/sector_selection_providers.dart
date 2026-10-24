import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../domain/entities/sector_entity.dart';

/// 1. Provider para el sector seleccionado. Inicia en null.
final selectedSectorProvider = StateProvider<SectorEntity?>((ref) => null);

/// 2. Provider para la cantidad de entradas. Inicia en 1.
final ticketQuantityProvider = StateProvider<int>((ref) => 1);

/// 3. Provider calculado para el precio total.
/// Se recalcula automáticamente cuando cambia el sector o la cantidad.
final totalPriceProvider = Provider<double>((ref) {
  final sector = ref.watch(selectedSectorProvider);
  final quantity = ref.watch(ticketQuantityProvider);
  
  if (sector == null) return 0.0;
  return sector.price * quantity;
});