import '../../domain/entities/match_entity.dart';

class MatchModel {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final String matchDate; // En la API viene como String
  final String stadium;
  final String competition;
  final String status;

  MatchModel({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.matchDate,
    required this.stadium,
    required this.competition,
    required this.status,
  });

  /// Factory para crear el Model desde un JSON (simulando la respuesta de la API)
  factory MatchModel.fromJson(Map<String, dynamic> json) {
    return MatchModel(
      id: json['id'] as String,
      homeTeam: json['homeTeam'] as String,
      awayTeam: json['awayTeam'] as String,
      matchDate: json['matchDate'] as String,
      stadium: json['stadium'] as String,
      competition: json['competition'] as String,
      status: json['status'] as String,
    );
  }

  /// Metodo clave: Traduce el Model (Data) a la Entity (Dominio)
  MatchEntity toEntity() {
    return MatchEntity(
      id: id,
      homeTeam: homeTeam,
      awayTeam: awayTeam,
      matchDate: DateTime.parse(matchDate), // Aqui convertimos el String a DateTime
      stadium: stadium,
      competition: competition,
      status: MatchStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => MatchStatus.upcoming,
      ),
    );
  }
}