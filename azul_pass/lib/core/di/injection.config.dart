// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:azul_pass/core/di/injection_module.dart' as _i856;
import 'package:azul_pass/data/datasources/mock/info_mock_datasource.dart'
    as _i626;
import 'package:azul_pass/data/datasources/mock/match_mock_datasources.dart'
    as _i246;
import 'package:azul_pass/domain/repositories/info_repository.dart' as _i178;
import 'package:azul_pass/domain/repositories/match_repository.dart' as _i274;
import 'package:azul_pass/domain/repositories/ticket_repository.dart' as _i169;
import 'package:azul_pass/domain/usecases/get_faqs.dart' as _i21;
import 'package:azul_pass/domain/usecases/get_match_by_id.dart' as _i813;
import 'package:azul_pass/domain/usecases/get_stadium_info.dart' as _i333;
import 'package:azul_pass/domain/usecases/get_upcoming_matches.dart' as _i267;
import 'package:azul_pass/domain/usecases/get_user_tickets.dart' as _i986;
import 'package:azul_pass/domain/usecases/process_payment.dart' as _i336;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectionModule = _$InjectionModule();
    gh.lazySingleton<_i246.MatchMockDataSource>(
      () => injectionModule.matchMockDataSource,
    );
    gh.lazySingleton<_i274.MatchRepository>(
      () => injectionModule.matchRepository,
    );
    gh.lazySingleton<_i169.TicketRepository>(
      () => injectionModule.ticketRepository,
    );
    gh.lazySingleton<_i626.InfoMockDataSource>(
      () => injectionModule.infoMockDataSource,
    );
    gh.lazySingleton<_i178.InfoRepository>(
      () => injectionModule.infoRepository,
    );
    gh.factory<_i21.GetFAQs>(() => _i21.GetFAQs(gh<_i178.InfoRepository>()));
    gh.factory<_i333.GetStadiumInfo>(
      () => _i333.GetStadiumInfo(gh<_i178.InfoRepository>()),
    );
    gh.factory<_i813.GetMatchById>(
      () => _i813.GetMatchById(gh<_i274.MatchRepository>()),
    );
    gh.factory<_i267.GetUpcomingMatches>(
      () => _i267.GetUpcomingMatches(gh<_i274.MatchRepository>()),
    );
    gh.factory<_i986.GetUserTickets>(
      () => _i986.GetUserTickets(gh<_i169.TicketRepository>()),
    );
    gh.factory<_i336.ProcessPayment>(
      () => _i336.ProcessPayment(gh<_i169.TicketRepository>()),
    );
    return this;
  }
}

class _$InjectionModule extends _i856.InjectionModule {}
