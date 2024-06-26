import 'package:flutter/material.dart';

class CardStyleII extends StatelessWidget {
  const CardStyleII({super.key,
  required this.child
  });
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
    
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3),
          spreadRadius: 5,
          blurRadius: 10,
          offset:const Offset(5, 3)
          )
        ],
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).colorScheme.primary,
        gradient: LinearGradient(colors: [
            Theme.of(context).colorScheme.secondary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary,
        ],
    transform: const GradientRotation(200),
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter
        ),
      
      ),
      child: child,
    );
  }
}