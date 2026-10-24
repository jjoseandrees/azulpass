import 'package:injectable/injectable.dart';
import '../entities/faq_entity.dart';
import '../repositories/info_repository.dart';

@injectable
class GetFAQs {
  final InfoRepository repository;
  GetFAQs(this.repository);

  Future<List<FaqEntity>> call() async {
    return await repository.getFAQs();
  }
}