import 'package:equatable/equatable.dart';

class TicketEntity extends Equatable {
  final String id;
  final String matchId;
  final String sectorName;
  final String buyerRut;
  final String buyerName;
  final DateTime purchaseDate;
  final String qrCodeData; // En la app final, esto sera un string cifrado

  const TicketEntity({
    required this.id,
    required this.matchId,
    required this.sectorName,
    required this.buyerRut,
    required this.buyerName,
    required this.purchaseDate,
    required this.qrCodeData,
  });

  @override
  List<Object?> get props => [id, matchId, sectorName, buyerRut, buyerName, purchaseDate, qrCodeData];
}