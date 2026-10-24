import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injection.dart';
import '../../../../domain/entities/ticket_entity.dart';
import '../../../../domain/usecases/get_user_tickets.dart';

part 'my_tickets_viewmodel.g.dart';

@riverpod
Future<List<TicketEntity>> myTickets(Ref ref) async {
  final useCase = getIt<GetUserTickets>();
  return await useCase();
}