import 'package:equatable/equatable.dart';

class BuyerEntity extends Equatable {
  final String rut;
  final String fullName;
  final String email;
  final String phone;
  final bool hasHinchasRegistry; // ¿Tiene Registro Nacional de Hinchas?

  const BuyerEntity({
    required this.rut,
    required this.fullName,
    required this.email,
    required this.phone,
    this.hasHinchasRegistry = false,
  });

  @override
  List<Object?> get props => [rut, fullName, email, phone, hasHinchasRegistry];
}