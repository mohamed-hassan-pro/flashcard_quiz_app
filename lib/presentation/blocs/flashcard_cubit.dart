import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/flashcard.dart';
import '../../domain/repositories/flashcard_repository.dart';
import 'flashcard_state.dart';

class FlashcardCubit extends Cubit<FlashcardState> {
  final FlashcardRepository repository;

  FlashcardCubit({required this.repository}) : super(FlashcardInitial());

  Future<void> loadFlashcards() async {
    emit(FlashcardLoading());
    try {
      final flashcards = await repository.getFlashcards();
      emit(FlashcardLoaded(flashcards: flashcards));
    } catch (e) {
      emit(FlashcardError(e.toString()));
    }
  }

  void nextCard() {
    if (state is FlashcardLoaded) {
      final currentState = state as FlashcardLoaded;
      if (currentState.flashcards.isNotEmpty && currentState.currentIndex < currentState.flashcards.length - 1) {
        emit(currentState.copyWith(
          currentIndex: currentState.currentIndex + 1,
          showAnswer: false,
        ));
      }
    }
  }

  void previousCard() {
    if (state is FlashcardLoaded) {
      final currentState = state as FlashcardLoaded;
      if (currentState.flashcards.isNotEmpty && currentState.currentIndex > 0) {
        emit(currentState.copyWith(
          currentIndex: currentState.currentIndex - 1,
          showAnswer: false,
        ));
      }
    }
  }

  void flipCard() {
    if (state is FlashcardLoaded) {
      final currentState = state as FlashcardLoaded;
      emit(currentState.copyWith(showAnswer: !currentState.showAnswer));
    }
  }

  Future<void> addFlashcard(String question, String answer) async {
    try {
      await repository.addFlashcard(Flashcard(question: question, answer: answer));
      await loadFlashcards();
    } catch (e) {
      emit(FlashcardError(e.toString()));
    }
  }

  Future<void> updateFlashcard(Flashcard flashcard) async {
    try {
      await repository.updateFlashcard(flashcard);
      await loadFlashcards();
    } catch (e) {
      emit(FlashcardError(e.toString()));
    }
  }

  Future<void> deleteFlashcard(int id) async {
    try {
      await repository.deleteFlashcard(id);
      await loadFlashcards();
    } catch (e) {
      emit(FlashcardError(e.toString()));
    }
  }
}
