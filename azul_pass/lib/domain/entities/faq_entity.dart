import 'package:equatable/equatable.dart';

class FaqEntity extends Equatable {
  final String id;
  final String question;
  final String answer;
  final FaqCategory category;

  const FaqEntity({
    required this.id,
    required this.question,
    required this.answer,
    required this.category,
  });

  @override
  List<Object?> get props => [id, question, answer, category];
}

enum FaqCategory {
  compra,      // Sobre la compra de entradas
  ingreso,     // Sobre el ingreso al estadio
  general      // Preguntas generales
}