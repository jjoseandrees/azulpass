import 'package:injectable/injectable.dart';
import '../../data/datasources/mock/match_mock_datasources.dart';
import '../../data/repositories/match_repository_impl.dart';
import '../../domain/repositories/match_repository.dart';

/// Módulo de inyección: Aquí registramos manualmente las dependencias
/// que Injectable no puede resolver automáticamente (como las interfaces).
@module
abstract class InjectionModule {
  
  /// Registramos el DataSource Mock como Singleton (una sola instancia en toda la app)
  @lazySingleton
  MatchMockDataSource get matchMockDataSource => MatchMockDataSource();

  /// Registramos la implementación del repositorio, diciéndole a GetIt
  /// que cuando alguien pida un `MatchRepository`, le dé un `MatchRepositoryImpl`.
  @lazySingleton
  MatchRepository get matchRepository => 
      MatchRepositoryImpl(matchMockDataSource);
}