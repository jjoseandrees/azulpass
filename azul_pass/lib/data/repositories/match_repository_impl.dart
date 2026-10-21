import '../../domain/entities/match_entity.dart';
import '../../domain/repositories/match_repository.dart';
import '../../data/datasources/mock/match_mock_datasources.dart';
import '../models/match_model.dart';

/// Implementa la interfaz del dominio usando nuestra fuente de datos Mock.
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
}