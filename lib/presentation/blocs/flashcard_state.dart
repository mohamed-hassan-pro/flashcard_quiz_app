import 'package:equatable/equatable.dart';
import '../../domain/entities/flashcard.dart';

abstract class FlashcardState extends Equatable {
  const FlashcardState();

  @override
  List<Object> get props => [];
}

class FlashcardInitial extends FlashcardState {}

class FlashcardLoading extends FlashcardState {}

class FlashcardLoaded extends FlashcardState {
  final List<Flashcard> flashcards;
  final int currentIndex;
  final bool showAnswer;

  const FlashcardLoaded({
    required this.flashcards,
    this.currentIndex = 0,
    this.showAnswer = false,
  });

  @override
  List<Object> get props => [flashcards, currentIndex, showAnswer];

  FlashcardLoaded copyWith({
    List<Flashcard>? flashcards,
    int? currentIndex,
    bool? showAnswer,
  }) {
    return FlashcardLoaded(
      flashcards: flashcards ?? this.flashcards,
      currentIndex: currentIndex ?? this.currentIndex,
      showAnswer: showAnswer ?? this.showAnswer,
    );
  }
}

class FlashcardError extends FlashcardState {
  final String message;

  const FlashcardError(this.message);

  @override
  List<Object> get props => [message];
}
