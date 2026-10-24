import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/injection.dart';
import '../../../../domain/entities/product_entity.dart';
import '../../../../domain/usecases/get_catalog.dart';

part 'shop_viewmodel.g.dart';

@riverpod
Future<List<ProductEntity>> catalog(Ref ref) async {
  final useCase = getIt<GetCatalog>();
  return await useCase();
}