import 'package:equatable/equatable.dart';

class MatchEntity extends Equatable {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final DateTime matchDate;
  final String stadium;
  final String competition; // Ej: "Primera Division", "Copa Libertadores"
  final MatchStatus status;

  const MatchEntity({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.matchDate,
    required this.stadium,
    required this.competition,
    this.status = MatchStatus.upcoming,
  });

  @override
  List<Object?> get props => [
        id,
        homeTeam,
        awayTeam,
        matchDate,
        stadium,
        competition,
        status,
      ];
}

/// Enum para los estados de un partido
enum MatchStatus {
  upcoming,  // Proximo
  live,      // En vivo
  finished,  // Finalizado
  postponed  // Postergado
}