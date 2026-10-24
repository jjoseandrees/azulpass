import '../../domain/entities/buyer_entity.dart';
import '../../domain/entities/sector_entity.dart';
import '../../domain/entities/ticket_entity.dart';
import '../../domain/repositories/ticket_repository.dart';

class TicketRepositoryImpl implements TicketRepository {

  final List<TicketEntity> _mockDatabase = [];

  @override
  Future<TicketEntity> processPayment({
    required String matchId,
    required SectorEntity sector,
    required int quantity,
    required BuyerEntity buyer,
  }) async {
    await Future.delayed(const Duration(milliseconds: 2500));
    
    final TicketEntity ticket = TicketEntity(
      id: 'TKT-${DateTime.now().millisecondsSinceEpoch}',
      matchId: matchId,
      sectorName: sector.name,
      buyerRut: buyer.rut,
      buyerName: buyer.fullName,
      purchaseDate: DateTime.now(),
      qrCodeData: 'AZULPASS-$matchId-${buyer.rut}-${sector.id}',
    );

    _mockDatabase.add(ticket);
    return ticket;
  }

  @override
  Future<List<TicketEntity>> getUserTickets() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return List.unmodifiable((_mockDatabase));
  }
}