import '../../domain/entities/faq_entity.dart';
import '../../domain/entities/stadium_info_entity.dart';
import '../../domain/repositories/info_repository.dart';
import '../datasources/mock/info_mock_datasource.dart';
import '../models/faq_model.dart';
import '../models/stadium_info_model.dart';

class InfoRepositoryImpl implements InfoRepository {
  final InfoMockDataSource dataSource;

  InfoRepositoryImpl(this.dataSource);

  @override
  Future<StadiumInfoEntity> getStadiumInfo() async {
    final json = await dataSource.getStadiumInfo();
    return StadiumInfoModel.fromJson(json).toEntity();
  }

  @override
  Future<List<FaqEntity>> getFAQs() async {
    final jsonList = await dataSource.getFAQs();
    return jsonList.map((json) => FaqModel.fromJson(json).toEntity()).toList();
  }
}