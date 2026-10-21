import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injection.dart';
import '../../../../domain/entities/match_entity.dart';
import '../../../../domain/usecases/get_upcoming_matches.dart';

part 'matches_viewmodel.g.dart';

/// Este Provider se encarga de pedir los datos al Caso de Uso.
/// Al ser un @riverpod que retorna un Future, Riverpod maneja 
/// automáticamente los estados: loading, data y error.
@riverpod
Future<List<MatchEntity>> matches(Ref ref) async {
  // Pedimos el Caso de Uso a nuestro contenedor de GetIt
  final useCase = getIt<GetUpcomingMatches>();
  return await useCase();
}