import 'package:injectable/injectable.dart';
import '../entities/ticket_entity.dart';
import '../repositories/ticket_repository.dart';

@injectable
class GetUserTickets {
  final TicketRepository repository;
  GetUserTickets(this.repository);

  Future<List<TicketEntity>> call() async {
    return await repository.getUserTickets();
  }
}