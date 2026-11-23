import '../../domain/entities/buyer_entity.dart';
import '../../domain/entities/sector_entity.dart';
import '../../domain/entities/ticket_entity.dart';
import '../../domain/repositories/ticket_repository.dart';
import '../datasources/remote/ticket_remote_datasources.dart';

class TicketRepositoryImpl implements TicketRepository {
  final TicketRemoteDataSource remoteDataSource;

  TicketRepositoryImpl(this.remoteDataSource);

  @override
  Future<TicketEntity> processPayment({
    required String matchId,
    required SectorEntity sector,
    required int quantity,
    required BuyerEntity buyer,
  }) async {
    final ticketModel = await remoteDataSource.purchaseTicket(
      matchId: int.parse(matchId),
      sectorId: int.parse(sector.id),
      quantity: quantity,
      buyerRut: buyer.rut,
      buyerName: buyer.fullName,
      buyerEmail: buyer.email,
      buyerPhone: buyer.phone,
    );

    return ticketModel.toEntity();
  }

  @override
  Future<List<TicketEntity>> getUserTickets(String rut) async {
    final ticketModels = await remoteDataSource.getUserTickets(rut);
    return ticketModels.map((model) => model.toEntity()).toList();
  }
}