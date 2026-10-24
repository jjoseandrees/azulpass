import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../shared/widgets/primary_button.dart';
import '../viewmodel/payment_viewmodel.dart';
import '../viewmodel/sector_selection_providers.dart';
import '../../../../domain/entities/buyer_entity.dart';
import '../../../../domain/entities/sector_entity.dart';
import '../../../../domain/entities/ticket_entity.dart';

class PaymentScreen extends ConsumerWidget {
  final String matchId;
  final BuyerEntity buyer;

  const PaymentScreen({super.key, required this.matchId, required this.buyer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentStatus = ref.watch(paymentProvider);
    final notifier = ref.read(paymentProvider.notifier);
    
    final selectedSector = ref.read(selectedSectorProvider);
    final quantity = ref.read(ticketQuantityProvider);
    final totalPrice = ref.read(totalPriceProvider);

    if (paymentStatus == PaymentStatus.success && notifier.purchasedTicket != null) {
      return _TicketSuccessScreen(ticket: notifier.purchasedTicket!);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmar Pago'),
        leading: paymentStatus == PaymentStatus.processing 
          ? null
          : IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
      ),
      body: paymentStatus == PaymentStatus.processing
          ? _buildProcessingState()
          : _buildCheckoutForm(context, ref, selectedSector!, quantity, totalPrice, notifier),
    );
  }

  Widget _buildProcessingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: AppColors.primaryBlue),
          SizedBox(height: 24),
          Text('Procesando pago con el banco...', style: TextStyle(fontSize: 16, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildCheckoutForm(
    BuildContext context,
    WidgetRef ref,
    SectorEntity sector,
    int quantity,
    double totalPrice,
    PaymentNotifier notifier,
  ) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.primaryBlue.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Resumen de compra', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              _buildRow('Partido', 'U vs Everton (ID: $matchId)'),
              _buildRow('Sector', sector.name),
              _buildRow('Cantidad', '$quantity entrada(s)'),
              _buildRow('Comprador', buyer.fullName),
              _buildRow('RUT', buyer.rut),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total a pagar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text('\$${totalPrice.toStringAsFixed(0)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        
        PrimaryButton(
          label: 'Pagar \$${totalPrice.toStringAsFixed(0)}',
          icon: Icons.lock,
          onPressed: () {
            notifier.processPayment(
              matchId: matchId,
              sector: sector,
              quantity: quantity,
              buyer: buyer,
            );
          },
        ),
        const SizedBox(height: 16),
        const Text(
          'Pago simulado. En producción se integraría con Webpay/Flow.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _TicketSuccessScreen extends StatelessWidget {
  final TicketEntity ticket;
  const _TicketSuccessScreen({required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('¡Compra Exitosa!'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: AppColors.success, size: 80),
              const SizedBox(height: 24),
              const Text('Tu entrada está lista', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Sector: ${ticket.sectorName}', style: const TextStyle(fontSize: 16, color: AppColors.textSecondary)),
              const SizedBox(height: 32),
              
              Container(
                width: 200,
                height: 200,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10)],
                ),
                child: const Icon(Icons.qr_code_2, size: 150, color: AppColors.primaryBlue),
              ),
              const SizedBox(height: 24),
              const Text('Presenta este código en la entrada del estadio', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 32),
              
              PrimaryButton(
                label: 'Volver al Inicio',
                onPressed: () {
                  context.go('/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}