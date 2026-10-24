import '../../domain/entities/product_entity.dart';

abstract class ShopRepository {
Future<List<ProductEntity>> getCatalog();
}