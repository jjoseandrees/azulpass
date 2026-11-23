import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injection.dart';
import '../../../../domain/entities/ticket_entity.dart';
import '../../../../data/models/ticket_model.dart';
import '../../../../data/datasources/remote/auth_remote_datasource.dart';

part 'my_tickets_viewmodel.g.dart';

@riverpod
class MyTicketsNotifier extends _$MyTicketsNotifier {
  @override
  Future<List<TicketEntity>> build() async {
    return [];
  }

  Future<void> login(String rut) async {
    state = const AsyncValue.loading();
    try {
      final authDataSource = getIt<AuthRemoteDataSource>();
      await authDataSource.login(rut);
      await _loadTickets();
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> _loadTickets() async {
    try {
      final authDataSource = getIt<AuthRemoteDataSource>();
      final ticketsJson = await authDataSource.getMyTickets();
      final tickets = ticketsJson.map((json) => TicketModel.fromJson(json).toEntity()).toList();
      state = AsyncValue.data(tickets);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}