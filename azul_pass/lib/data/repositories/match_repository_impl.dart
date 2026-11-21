import '../../domain/entities/match_entity.dart';
import '../../domain/repositories/match_repository.dart';
import '../../data/datasources/remote/match_remote_datasources.dart';
import '../models/match_model.dart';

class MatchRepositoryImpl implements MatchRepository {
  final MatchRemoteDataSource remoteDataSource;

  MatchRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<MatchEntity>> getUpcomingMatches() async {
    final jsonList = await remoteDataSource.getUpcomingMatches();
    final models = jsonList.map((json) => MatchModel.fromJson(json)).toList();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<MatchEntity> getMatchById(String id) async {
    final json = await remoteDataSource.getMatchById(id);
    final model = MatchModel.fromJson(json);
    return model.toEntity();
  }
}