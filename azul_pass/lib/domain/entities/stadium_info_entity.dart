import 'package:equatable/equatable.dart';

class StadiumInfoEntity extends Equatable {
  final String name;
  final String address;
  final List<String> transportOptions;
  final List<String> parkingInfo;
  final List<String> entryRequirements;

  const StadiumInfoEntity({
    required this.name,
    required this.address,
    required this.transportOptions,
    required this.parkingInfo,
    required this.entryRequirements,
  });

  @override
  List<Object?> get props => [name, address, transportOptions, parkingInfo, entryRequirements];
}