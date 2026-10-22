import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injection.dart';
import '../../../../domain/entities/match_entity.dart';
import '../../../../domain/usecases/get_match_by_id.dart'; // Asegúrate de crear este usecase

part 'match_detail_viewmodel.g.dart';

@riverpod
Future<MatchEntity> matchDetail(Ref ref, String matchId) async {
  final useCase = getIt<GetMatchById>();
  final match = await useCase(matchId);
  return match;
}