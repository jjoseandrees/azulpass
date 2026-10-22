import '../../domain/entities/match_entity.dart';
import '../../domain/repositories/match_repository.dart';
import '../../data/datasources/mock/match_mock_datasources.dart';
import '../models/match_model.dart';

class MatchRepositoryImpl implements MatchRepository {
  final MatchMockDataSource dataSource;

  MatchRepositoryImpl(this.dataSource);

  @override
  Future<List<MatchEntity>> getUpcomingMatches() async {
    // 1. Pedimos los datos crudos (JSON)
    final jsonList = await dataSource.getUpcomingMatches();
    
    // 2. Los convertimos a Models
    final models = jsonList.map((json) => MatchModel.fromJson(json)).toList();
    
    // 3. Los traducimos a Entities de Dominio y los devolvemos
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<MatchEntity> getMatchById(String id) async {
    // 1. Pedimos los datos crudos (JSON) del partido por ID
    final json = await dataSource.getMatchById(id);
    
    // 2. Si no encontramos el partido, lanzamos una excepción
    if (json == null) {
      throw Exception('Match not found');
    }
    
    // 3. Convertimos el JSON a Model y luego a Entity de Dominio
    final model = MatchModel.fromJson(json);
    return model.toEntity();
  }
}