import '../../domain/entities/sector_entity.dart';

class SectorModel {
  final String id;
  final String name;
  final double price;
  final bool isAvailable;

  SectorModel({
    required this.id,
    required this.name,
    required this.price,
    this.isAvailable = true,
  });

  /// Factory para crear el Model desde un JSON (simulando la respuesta de la API)
  factory SectorModel.fromJson(Map<String, dynamic> json) {
    return SectorModel(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      isAvailable: json['isAvailable'] as bool? ?? true,
    );
  }

  /// Metodo clave: Traduce el Model (Data) a la Entity (Dominio)
  SectorEntity toEntity() {
    return SectorEntity(
      id: id,
      name: name,
      price: price,
      isAvailable: isAvailable,
    );
  }
}