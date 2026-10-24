import '../entities/faq_entity.dart';
import '../entities/stadium_info_entity.dart';

abstract class InfoRepository {
  Future<StadiumInfoEntity> getStadiumInfo();
  Future<List<FaqEntity>> getFAQs();
}