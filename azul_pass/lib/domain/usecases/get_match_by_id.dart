import 'package:injectable/injectable.dart';
import '../entities/match_entity.dart';
import '../repositories/match_repository.dart';

@injectable
class GetMatchById {
  final MatchRepository repository;

  GetMatchById(this.repository);

  Future<MatchEntity> call(String id) async {
    return await repository.getMatchById(id);
  }
}