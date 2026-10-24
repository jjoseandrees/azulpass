import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/shop_repository.dart';
import '../datasources/mock/shop_mock_datasource.dart';
import '../models/product_model.dart';

class ShopRepositoryImpl implements ShopRepository {
  final ShopMockDataSource dataSource;
  ShopRepositoryImpl(this.dataSource);

  @override
  Future<List<ProductEntity>> getCatalog() async {
    final jsonList = await dataSource.getCatalog();
    return jsonList.map((json) => ProductModel.fromJson(json).toEntity()).toList();
  }
}