import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waterlevelmonitor/features/view/provider/waterlevelprovider.dart';
import 'package:waterlevelmonitor/features/view/widgets/cardstyle.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<WaterLevelProvider>(context);
    return Expanded(child: CardStyle(child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Settings',style: TextStyle(fontSize: 20),),
          SizedBox(height: 40,),
          Text('Timer Duration',style: TextStyle(fontSize: 14),),
          Row(
            children: [
              IconButton(onPressed: (){
                prov.timerseconds(false);
              }, icon:FaIcon(FontAwesomeIcons.minus,size: 14,) ),
              SizedBox(width: 10,),
              Text('${prov.seconds}'),
              SizedBox(width: 10,),
              IconButton(onPressed: (){
          prov.timerseconds(true);
              }, icon:FaIcon(FontAwesomeIcons.plus,size: 14,) ),
            ],
          )
        ],
      ),
    )),);
  }
}