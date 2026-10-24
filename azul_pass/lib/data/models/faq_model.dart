import '../../domain/entities/faq_entity.dart';

class FaqModel {
  final String id;
  final String question;
  final String answer;
  final String category;

  FaqModel({
    required this.id,
    required this.question,
    required this.answer,
    required this.category,
  });

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['id'] as String,
      question: json['question'] as String,
      answer: json['answer'] as String,
      category: json['category'] as String,
    );
  }

  FaqEntity toEntity() {
    return FaqEntity(
      id: id,
      question: question,
      answer: answer,
      category: FaqCategory.values.firstWhere(
        (e) => e.name == category,
        orElse: () => FaqCategory.general,
      ),
    );
  }
}