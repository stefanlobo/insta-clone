import 'package:flutter/material.dart';
import 'package:insta_clone/views/components/animations/empty_contents_animation_view.dart';

class EmptyContentsWithTextAnimationsView extends StatelessWidget {
  final String text;
  const EmptyContentsWithTextAnimationsView({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(text, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white54)),
          ),
          const EmptyContentsAnimationView(),
        ],
      ),
    );
  }
}
