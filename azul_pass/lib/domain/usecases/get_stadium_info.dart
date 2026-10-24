import 'package:injectable/injectable.dart';
import '../entities/stadium_info_entity.dart';
import '../repositories/info_repository.dart';

@injectable
class GetStadiumInfo {
  final InfoRepository repository;
  GetStadiumInfo(this.repository);

  Future<StadiumInfoEntity> call() async {
    return await repository.getStadiumInfo();
  }
}