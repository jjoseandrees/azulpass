import '../entities/buyer_entity.dart';
import '../entities/sector_entity.dart';
import '../entities/ticket_entity.dart';

abstract class TicketRepository {
  /// Simula el proceso de pago. Retorna la entrada si es exitoso.
  Future<TicketEntity> processPayment({
    required String matchId,
    required SectorEntity sector,
    required int quantity,
    required BuyerEntity buyer,
  });
}