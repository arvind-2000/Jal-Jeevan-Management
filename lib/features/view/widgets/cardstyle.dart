import 'package:flutter/material.dart';

class CardStyle extends StatelessWidget {
  const CardStyle({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
    
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset:const Offset(5, 3)
          )
        ],
        borderRadius: BorderRadius.circular(4),
        color: Theme.of(context).colorScheme.primary,
    //     gradient:  LinearGradient(colors: [
    //         Theme.of(context).colorScheme.onPrimary,
    //         Theme.of(context).colorScheme.primary,
    //     ],
    // transform: const GradientRotation(200),
    //     begin: Alignment.topCenter,
    //     end: Alignment.bottomCenter
    //     ),
      
      ),
      child: child,
    );
  }
}
