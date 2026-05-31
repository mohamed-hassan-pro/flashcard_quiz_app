import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/flashcard_cubit.dart';
import '../blocs/flashcard_state.dart';
import '../widgets/flashcard_card.dart';
import '../widgets/navigation_controls.dart';
import '../widgets/action_buttons.dart';
import 'add_edit_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<FlashcardCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcard Quiz App'),
        backgroundColor: Colors.blueAccent,
      ),
      body: BlocBuilder<FlashcardCubit, FlashcardState>(
        builder: (context, state) {
          if (state is FlashcardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FlashcardLoaded) {
            if (state.flashcards.isEmpty) {
              return const Center(child: Text('No flashcards yet. Add some!'));
            }

            final currentCard = state.flashcards[state.currentIndex];

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: FlashcardCard(
                    flashcard: currentCard,
                    showAnswer: state.showAnswer,
                    onTap: () => cubit.flipCard(),
                  ),
                ),
                const SizedBox(height: 20),
                NavigationControls(
                  hasPrevious: state.currentIndex > 0,
                  hasNext: state.currentIndex < state.flashcards.length - 1,
                  onPrevious: () => cubit.previousCard(),
                  onFlip: () => cubit.flipCard(),
                  onNext: () => cubit.nextCard(),
                ),
                const SizedBox(height: 20),
                ActionButtons(
                  onEdit: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddEditPage(flashcard: currentCard),
                      ),
                    ).then((_) => cubit.loadFlashcards());
                  },
                  onDelete: () => cubit.deleteFlashcard(currentCard.id!),
                ),
              ],
            );
          } else if (state is FlashcardError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditPage()),
          ).then((_) => cubit.loadFlashcards());
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
