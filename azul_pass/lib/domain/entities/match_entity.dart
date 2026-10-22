import 'package:equatable/equatable.dart';
import 'sector_entity.dart';

class MatchEntity extends Equatable {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final DateTime matchDate;
  final String stadium;
  final String competition; // Ej: "Primera Division", "Copa Libertadores"
  final MatchStatus status;
  final List<String> requirements; // Lista de requisitos para este partido (ej: "VIP", "General", "Menores de 18")
  final List<String> salePhases; // Lista de fases de venta disponibles para este partido
  final List<SectorEntity> avalaibleSectors; // Lista de sectores disponibles para este partido

  const MatchEntity({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.matchDate,
    required this.stadium,
    required this.competition,
    this.status = MatchStatus.upcoming,
    this.requirements = const [],
    this.salePhases = const [],
    this.avalaibleSectors = const [],
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
        requirements,
        salePhases,
        avalaibleSectors,
      ];
}

/// Enum para los estados de un partido
enum MatchStatus {
  upcoming,  // Proximo
  live,      // En vivo
  finished,  // Finalizado
  postponed  // Postergado
}