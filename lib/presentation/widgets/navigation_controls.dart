import 'package:flutter/material.dart';

class NavigationControls extends StatelessWidget {
  final bool hasPrevious;
  final bool hasNext;
  final VoidCallback onPrevious;
  final VoidCallback onFlip;
  final VoidCallback onNext;

  const NavigationControls({
    Key? key,
    required this.hasPrevious,
    required this.hasNext,
    required this.onPrevious,
    required this.onFlip,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: hasPrevious ? onPrevious : null,
          icon: const Icon(Icons.arrow_back),
          label: const Text('Previous'),
        ),
        ElevatedButton.icon(
          onPressed: onFlip,
          icon: const Icon(Icons.flip),
          label: const Text('Show Answer'),
        ),
        ElevatedButton.icon(
          onPressed: hasNext ? onNext : null,
          icon: const Icon(Icons.arrow_forward),
          label: const Text('Next'),
        ),
      ],
    );
  }
}
