import '../entities/product_entity.dart';
import '../repositories/shop_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCatalog {
  final ShopRepository repository;
  GetCatalog(this.repository);

  Future<List<ProductEntity>> call() async {
    return await repository.getCatalog();
  }
}