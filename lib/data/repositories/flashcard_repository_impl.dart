import '../../domain/entities/flashcard.dart';
import '../../domain/repositories/flashcard_repository.dart';
import '../datasources/flashcard_local_data_source.dart';
import '../models/flashcard_model.dart';

class FlashcardRepositoryImpl implements FlashcardRepository {
  final FlashcardLocalDataSource localDataSource;

  FlashcardRepositoryImpl({required this.localDataSource});

  @override
  Future<List<Flashcard>> getFlashcards() async {
    return await localDataSource.getFlashcards();
  }

  @override
  Future<void> addFlashcard(Flashcard flashcard) async {
    final model = FlashcardModel(
      question: flashcard.question,
      answer: flashcard.answer,
    );
    await localDataSource.addFlashcard(model);
  }

  @override
  Future<void> updateFlashcard(Flashcard flashcard) async {
    final model = FlashcardModel(
      id: flashcard.id,
      question: flashcard.question,
      answer: flashcard.answer,
    );
    await localDataSource.updateFlashcard(model);
  }

  @override
  Future<void> deleteFlashcard(int id) async {
    await localDataSource.deleteFlashcard(id);
  }
}
