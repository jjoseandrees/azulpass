import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// 1. Data Sources (Mock y Remote)
import '../../data/datasources/mock/info_mock_datasource.dart';
import '../../data/datasources/mock/shop_mock_datasource.dart';
import '../../data/datasources/remote/match_remote_datasources.dart';

// 2. Implementaciones de Repositorios
import '../../data/repositories/info_repository_impl.dart';
import '../../data/repositories/match_repository_impl.dart';
import '../../data/repositories/shop_repository_impl.dart';
import '../../data/repositories/ticket_repository_impl.dart';

// 3. Interfaces de Dominio
import '../../domain/repositories/info_repository.dart';
import '../../domain/repositories/match_repository.dart';
import '../../domain/repositories/shop_repository.dart';
import '../../domain/repositories/ticket_repository.dart';

final getIt = GetIt.instance;

@module
abstract class InjectionModule {
  
  // ==========================================
  // HTTP & REMOTE DATA SOURCES
  // ==========================================
  
  @lazySingleton
  http.Client get httpClient => http.Client();

  @lazySingleton
  MatchRemoteDataSource get matchRemoteDataSource => 
      MatchRemoteDataSource(client: getIt<http.Client>());

  // ==========================================
  // REPOSITORIOS (Las interfaces que usa el dominio)
  // ==========================================

  // Partidos (Ahora conectado al Backend Real)
  @lazySingleton
  MatchRepository get matchRepository => 
      MatchRepositoryImpl(matchRemoteDataSource);

  // Entradas
  @lazySingleton
  TicketRepository get ticketRepository => TicketRepositoryImpl();

  // Info (Sigue usando Mock)
  @lazySingleton
  InfoMockDataSource get infoMockDataSource => InfoMockDataSource();

  @lazySingleton
  InfoRepository get infoRepository => InfoRepositoryImpl(infoMockDataSource);

  // Tienda (Sigue usando Mock)
  @lazySingleton
  ShopMockDataSource get shopMockDataSource => ShopMockDataSource();

  @lazySingleton
  ShopRepository get shopRepository => ShopRepositoryImpl(shopMockDataSource);
}