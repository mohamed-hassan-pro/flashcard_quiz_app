import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/flashcard.dart';
import '../blocs/flashcard_cubit.dart';

class AddEditPage extends StatefulWidget {
  final Flashcard? flashcard;

  const AddEditPage({Key? key, this.flashcard}) : super(key: key);

  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final _questionController = TextEditingController();
  final _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.flashcard != null) {
      _questionController.text = widget.flashcard!.question;
      _answerController.text = widget.flashcard!.answer;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.flashcard == null ? 'Add Flashcard' : 'Edit Flashcard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _questionController,
              decoration: InputDecoration(labelText: 'Question', border: OutlineInputBorder()),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _answerController,
              decoration: InputDecoration(labelText: 'Answer', border: OutlineInputBorder()),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_questionController.text.isNotEmpty && _answerController.text.isNotEmpty) {
                  if (widget.flashcard == null) {
                    context.read<FlashcardCubit>().addFlashcard(
                      _questionController.text,
                      _answerController.text,
                    );
                  } else {
                    final updated = Flashcard(
                      id: widget.flashcard!.id,
                      question: _questionController.text,
                      answer: _answerController.text,
                    );
                    context.read<FlashcardCubit>().updateFlashcard(updated);
                  }
                  Navigator.pop(context);
                }
              },
              child: Text('Save'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
              ),
            )
          ],
        ),
      ),
    );
  }
}
