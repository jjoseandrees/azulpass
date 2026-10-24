import '../../domain/entities/stadium_info_entity.dart';

class StadiumInfoModel {
  final String name;
  final String address;
  final List<String> transportOptions;
  final List<String> parkingInfo;
  final List<String> entryRequirements;

  StadiumInfoModel({
    required this.name,
    required this.address,
    required this.transportOptions,
    required this.parkingInfo,
    required this.entryRequirements,
  });

  factory StadiumInfoModel.fromJson(Map<String, dynamic> json) {
    return StadiumInfoModel(
      name: json['name'] as String,
      address: json['address'] as String,
      transportOptions: List<String>.from(json['transportOptions']),
      parkingInfo: List<String>.from(json['parkingInfo']),
      entryRequirements: List<String>.from(json['entryRequirements']),
    );
  }

  StadiumInfoEntity toEntity() {
    return StadiumInfoEntity(
      name: name,
      address: address,
      transportOptions: transportOptions,
      parkingInfo: parkingInfo,
      entryRequirements: entryRequirements,
    );
  }
}