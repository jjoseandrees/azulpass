import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injection.dart';
import '../../../../domain/entities/buyer_entity.dart';
import '../../../../domain/entities/sector_entity.dart';
import '../../../../domain/entities/ticket_entity.dart';
import '../../../../domain/usecases/process_payment.dart';

part 'payment_viewmodel.g.dart';

// 1. Definimos los estados posibles
enum PaymentStatus { idle, processing, success, error }

// 2. El ViewModel
@riverpod
class PaymentNotifier extends _$PaymentNotifier {
  @override
  PaymentStatus build() => PaymentStatus.idle;

  TicketEntity? _purchasedTicket;
  TicketEntity? get purchasedTicket => _purchasedTicket;

  Future<void> processPayment({
    required String matchId,
    required SectorEntity sector,
    required int quantity,
    required BuyerEntity buyer,
  }) async {
    state = PaymentStatus.processing;
    try {
      final useCase = getIt<ProcessPayment>();
      _purchasedTicket = await useCase(
        matchId: matchId,
        sector: sector,
        quantity: quantity,
        buyer: buyer,
      );
      state = PaymentStatus.success;
    } catch (e) {
      state = PaymentStatus.error;
      // En la app final, aquí guardaremos los mensaje de error
    }
  }

  void reset() {
    state = PaymentStatus.idle;
    _purchasedTicket = null;
  }
}