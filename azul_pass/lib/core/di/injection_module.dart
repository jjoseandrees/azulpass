import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import '../../data/datasources/mock/match_mock_datasources.dart';
import '../../data/repositories/match_repository_impl.dart';
import '../../domain/repositories/ticket_repository_impl.dart';
import '../../domain/repositories/match_repository.dart';
import '../../domain/repositories/ticket_repository.dart';
import '../../data/datasources/mock/info_mock_datasource.dart';
import '../../data/repositories/info_repository_impl.dart';
import '../../domain/repositories/info_repository.dart';

final getIt = GetIt.instance;

@module
abstract class InjectionModule {
  
  @lazySingleton
  MatchMockDataSource get matchMockDataSource => MatchMockDataSource();

  @lazySingleton
  MatchRepository get matchRepository => 
      MatchRepositoryImpl(matchMockDataSource);

  @lazySingleton
  TicketRepository get ticketRepository => TicketRepositoryImpl();

  @lazySingleton
  InfoMockDataSource get infoMockDataSource => InfoMockDataSource();

  @lazySingleton
  InfoRepository get infoRepository => InfoRepositoryImpl(infoMockDataSource);
  
}