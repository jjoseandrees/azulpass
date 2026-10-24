import '../../domain/entities/product_entity.dart';

class ProductModel {
  final String id;
  final String name;
  final double price;
  final String category;
  final String iconName;

  ProductModel({required this.id, required this.name, required this.price, required this.category, required this.iconName});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      category: json['category'],
      iconName: json['iconName'],
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id, name: name, price: price, category: category, iconName: iconName,
    );
  }
}