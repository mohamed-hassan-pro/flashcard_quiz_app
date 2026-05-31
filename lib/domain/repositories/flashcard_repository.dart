import '../entities/flashcard.dart';

abstract class FlashcardRepository {
  Future<List<Flashcard>> getFlashcards();
  Future<void> addFlashcard(Flashcard flashcard);
  Future<void> updateFlashcard(Flashcard flashcard);
  Future<void> deleteFlashcard(int id);
}
