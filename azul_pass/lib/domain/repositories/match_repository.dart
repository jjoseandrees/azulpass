import '../entities/match_entity.dart';

abstract class MatchRepository {
  Future<List<MatchEntity>> getUpcomingMatches();
  Future<MatchEntity> getMatchById(String id);
}