import '../entities/match_entity.dart';
import '../repositories/match_repository.dart';

class GetUpcomingMatches {
  final MatchRepository repository;

  GetUpcomingMatches(this.repository);

  Future<List<MatchEntity>> call() async {
    return await repository.getUpcomingMatches();
  }
}