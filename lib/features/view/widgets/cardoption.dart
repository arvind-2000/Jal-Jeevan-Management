import 'package:flutter/material.dart';

class CardOptionBorder extends StatelessWidget {
  const CardOptionBorder({
    super.key,
    required this.title,
    required this.isSelect,
    
  });
  final String title;
  final bool isSelect;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8,horizontal: 16),
      decoration: BoxDecoration(
        color: isSelect?Theme.of(context).colorScheme.secondary.withOpacity(0.2):null,
        border: Border.all(color:isSelect?Theme.of(context).colorScheme.secondary.withOpacity(0.8):Theme.of(context).colorScheme.surface.withOpacity(0.5),width: 1),
        borderRadius: BorderRadius.circular(4)
      ),
      child: Text(title,style:const TextStyle(fontSize: 12),),
    );
  }
}