import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SideCardWidget extends StatelessWidget {
  const SideCardWidget({
    super.key,
    required this.level,
    required this.name
  });
  final String name;
  final double level;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
      
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              Row(
                children: [
                  FaIcon(FontAwesomeIcons.temperatureFull),
                  SizedBox(width: 20,),
                  Text(name,style: TextStyle(fontSize: 24),),
                ],
              ),
              SizedBox(height: 20,),
              Text('${level.toStringAsFixed(0)} %',style: TextStyle(fontSize: 34),)
          ],
        ),


    );
  }
}
