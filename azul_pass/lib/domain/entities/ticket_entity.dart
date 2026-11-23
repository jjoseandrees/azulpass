import 'package:equatable/equatable.dart';

class TicketEntity extends Equatable {
  final String id;
  final String matchId;
  final String sectorName;
  final String buyerRut;
  final String buyerName;
  final DateTime purchaseDate;
  final String qrCodeData; // En la app final, esto sera un string cifrado

  final String homeTeam;
  final String awayTeam;
  final String stadium;
  final DateTime? matchDate;
  final int? quantity;
  final double? totalPrice;

  const TicketEntity({
    required this.id,
    required this.matchId,
    required this.sectorName,
    required this.buyerRut,
    required this.buyerName,
    required this.purchaseDate,
    required this.qrCodeData,
    this.homeTeam = '',
    this.awayTeam = '',
    this.stadium = '',
    this.matchDate,
    this.quantity,
    this.totalPrice,
  });

  @override
  List<Object?> get props => [
    id, matchId, sectorName, buyerRut, buyerName, purchaseDate, qrCodeData,
    homeTeam, awayTeam, stadium, matchDate, quantity, totalPrice,
  ];
}