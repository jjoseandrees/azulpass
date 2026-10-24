import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final double price;
  final String category; // Ej: "Poleras", "Accesorios"
  final String iconName; // Usaremos nombres de iconos de Material para simular las imágenes

  const ProductEntity({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    required this.iconName,
  });

  @override
  List<Object?> get props => [id, name, price, category, iconName];
}