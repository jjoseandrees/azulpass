import 'package:equatable/equatable.dart';

class SectorEntity extends Equatable {
  final String id;
  final String name; // Ej: "Galería Andes", "Preferencia"
  final double price; // Precio en CLP
  final bool isAvailable;

  const SectorEntity({
    required this.id,
    required this.name,
    required this.price,
    this.isAvailable = true,
  });

  @override
  List<Object?> get props => [id, name, price, isAvailable];
}