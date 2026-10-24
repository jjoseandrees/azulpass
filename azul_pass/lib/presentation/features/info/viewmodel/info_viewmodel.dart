import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injection.dart';
import '../../../../domain/entities/faq_entity.dart';
import '../../../../domain/entities/stadium_info_entity.dart';
import '../../../../domain/usecases/get_faqs.dart';
import '../../../../domain/usecases/get_stadium_info.dart';

part 'info_viewmodel.g.dart';

@riverpod
Future<StadiumInfoEntity> stadiumInfo(Ref ref) async {
  final useCase = getIt<GetStadiumInfo>();
  return await useCase();
}

@riverpod
Future<List<FaqEntity>> faqs(Ref ref) async {
  final useCase = getIt<GetFAQs>();
  return await useCase();
}