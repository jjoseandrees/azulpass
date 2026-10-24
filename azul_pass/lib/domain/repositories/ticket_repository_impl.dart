import '../../domain/entities/buyer_entity.dart';
import '../../domain/entities/sector_entity.dart';
import '../../domain/entities/ticket_entity.dart';
import '../../domain/repositories/ticket_repository.dart';

class TicketRepositoryImpl implements TicketRepository {
  @override
  Future<TicketEntity> processPayment({
    required String matchId,
    required SectorEntity sector,
    required int quantity,
    required BuyerEntity buyer,
  }) async {
    await Future.delayed(const Duration(milliseconds: 2500));
    
    return TicketEntity(
      id: 'TKT-${DateTime.now().millisecondsSinceEpoch}',
      matchId: matchId,
      sectorName: sector.name,
      buyerRut: buyer.rut,
      buyerName: buyer.fullName,
      purchaseDate: DateTime.now(),
      qrCodeData: 'AZULPASS-$matchId-${buyer.rut}-${sector.id}',
    );
  }
}