import 'package:flutter/material.dart';

class ProgressController extends StatelessWidget {
  const ProgressController({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}