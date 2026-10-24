import '../entities/buyer_entity.dart';
import '../entities/sector_entity.dart';
import '../entities/ticket_entity.dart';
import '../repositories/ticket_repository.dart';

class ProcessPayment {
  final TicketRepository repository;
  ProcessPayment(this.repository);

  Future<TicketEntity> call({
    required String matchId,
    required SectorEntity sector,
    required int quantity,
    required BuyerEntity buyer,
  }) {
    return repository.processPayment(
      matchId: matchId,
      sector: sector,
      quantity: quantity,
      buyer: buyer,
    );
  }
}