import '../../domain/entities/ticket_entity.dart';

class TicketModel {
  final int id;
  final int matchId;
  final String sectorName;
  final String buyerRut;
  final String buyerName;
  final String purchaseDate;
  final String qrCode;
  final int? quantity;
  final double? totalPrice;
  final String? homeTeam;
  final String? awayTeam;
  final String? stadium;
  final String? matchDate;

  TicketModel({
    required this.id,
    required this.matchId,
    required this.sectorName,
    required this.buyerRut,
    required this.buyerName,
    required this.purchaseDate,
    required this.qrCode,
    this.quantity,
    this.totalPrice,
    this.homeTeam,
    this.awayTeam,
    this.stadium,
    this.matchDate,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json['id'] ?? 0,
      matchId: json['match_id'] ?? json['matchId'] ?? 0,
      sectorName: json['sector_name'] ?? json['sectorName'] ?? '',
      buyerRut: json['buyer_rut'] ?? json['buyerRut'] ?? '',
      buyerName: json['buyer_name'] ?? json['buyerName'] ?? '',
      purchaseDate: json['purchase_date'] ?? json['purchaseDate'] ?? '',
      qrCode: json['qr_code'] ?? json['qrCode'] ?? '',
      quantity: json['quantity'],
      totalPrice: json['total_price'] != null ? double.tryParse(json['total_price'].toString()) : null,
      homeTeam: json['home_team'] ?? json['homeTeam'],
      awayTeam: json['away_team'] ?? json['awayTeam'],
      stadium: json['stadium'],
      matchDate: json['match_date'] ?? json['matchDate'],
    );
  }

  TicketEntity toEntity() {
    return TicketEntity(
      id: id.toString(),
      matchId: matchId.toString(),
      sectorName: sectorName,
      buyerRut: buyerRut,
      buyerName: buyerName,
      purchaseDate: DateTime.parse(purchaseDate),
      qrCodeData: qrCode,
      homeTeam: homeTeam ?? '',
      awayTeam: awayTeam ?? '',
      stadium: stadium ?? '',
      matchDate: matchDate != null ? DateTime.tryParse(matchDate!) : null,
      quantity: quantity,
      totalPrice: totalPrice,
    );
  }
}