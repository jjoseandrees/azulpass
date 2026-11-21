import '../../domain/entities/match_entity.dart';
import '../../data/models/sector_model.dart';

class MatchModel {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final String matchDate; // En la API viene como String
  final String stadium;
  final String competition;
  final String status;
  final List<String> requirements;
  final List<String> salePhases;
  final List<Map<String, dynamic>> sectors;

  MatchModel({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.matchDate,
    required this.stadium,
    required this.competition,
    required this.status,
    required this.requirements,
    required this.salePhases,
    required this.sectors,
  });

factory MatchModel.fromJson(Map<String, dynamic> json) {
  return MatchModel(
    id: json['id']?.toString() ?? '',
    homeTeam: json['homeTeam'] ?? json['home_team'] ?? '',
    awayTeam: json['awayTeam'] ?? json['away_team'] ?? '',
    matchDate: json['matchDate'] ?? json['match_date'] ?? '',
    stadium: json['stadium'] ?? '',
    competition: json['competition'] ?? '',
    status: json['status'] ?? 'upcoming',
    requirements: List<String>.from(json['requirements'] ?? []),
    salePhases: List<String>.from(json['salePhases'] ?? json['sale_phases'] ?? []),
    sectors: List<Map<String, dynamic>>.from(json['availableSectors'] ?? json['sectors'] ?? []),
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
      requirements: requirements,
      salePhases: salePhases,
      availableSectors: sectors.map((s) => SectorModel.fromJson(s).toEntity()).toList()
    );
  }
}