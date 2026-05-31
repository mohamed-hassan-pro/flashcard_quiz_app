import 'package:flutter_test/flutter_test.dart';
import 'package:flashcard_quiz_app/data/models/flashcard_model.dart';

void main() {
  group('FlashcardModel Tests', () {
    test('should convert from map and to map correctly', () {
      const model = FlashcardModel(
        id: 1,
        question: 'What is clean architecture?',
        answer: 'A software design philosophy.',
      );

      final map = model.toMap();
      expect(map['id'], 1);
      expect(map['question'], 'What is clean architecture?');
      expect(map['answer'], 'A software design philosophy.');

      final fromMap = FlashcardModel.fromMap(map);
      expect(fromMap.id, model.id);
      expect(fromMap.question, model.question);
      expect(fromMap.answer, model.answer);
    });
  });
}
