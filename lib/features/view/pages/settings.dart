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
          const Text('Settings',style: TextStyle(fontSize: 20),),
          const SizedBox(height: 40,),
          CardStyle(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.clock,size: 14,),
                          SizedBox(width: 10,),
                          const Text('Timer Duration',style: TextStyle(fontSize: 14),),
                        ],
                      ),
                      SizedBox(height: 10,),
                     Text('seconds',style: TextStyle(fontSize: 12,color: Theme.of(context).colorScheme.surface.withOpacity(0.5)),),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: (){
                        prov.timerseconds(false);
                      }, icon:const FaIcon(FontAwesomeIcons.minus,size: 14,) ),
                      const SizedBox(width: 10,),
                      Text('${prov.seconds}'),
                      const SizedBox(width: 10,),
                      IconButton(onPressed: (){
                  prov.timerseconds(true);
                      }, icon:const FaIcon(FontAwesomeIcons.plus,size: 14,) ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          CardStyle(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                           FaIcon(FontAwesomeIcons.link,size: 14,),
                          SizedBox(width: 10,),
                          const Text('Api Data',style: TextStyle(fontSize: 14),),
                        ],
                      ),
                            SizedBox(height: 10,),
                          Text('Change data from api to dummy.\nTesting purpose',style: TextStyle(fontSize: 12,color: Theme.of(context).colorScheme.surface.withOpacity(0.5)),),
                    ],
                  ),
                  Switch(
                     activeTrackColor: Colors.white,
                            activeColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Colors.grey.shade500,
                            inactiveTrackColor: Colors.grey.shade300,
                            hoverColor: prov.isOnoff?Theme.of(context).colorScheme.secondary:Theme.of(context).colorScheme.primary,
                    value: prov.isDataApi, onChanged: (v){
                      prov.changeDataApi(v);
                  })
                ],
              ),
            ),
          ),
           SizedBox(height: 20,),
          CardStyle(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                           FaIcon(FontAwesomeIcons.link,size: 14,),
                          SizedBox(width: 10,),
                          const Text('Field 8',style: TextStyle(fontSize: 14),),
                        ],
                      ),
                            SizedBox(height: 10,),
                          Text('changing pump switches',style: TextStyle(fontSize: 12,color: Theme.of(context).colorScheme.surface.withOpacity(0.5)),),
                    ],
                  ),
                  Switch(
                     activeTrackColor: Colors.white,
                            activeColor: Theme.of(context).colorScheme.secondary,
                              inactiveThumbColor: Colors.grey.shade500,
                            inactiveTrackColor: Colors.grey.shade300,
                            hoverColor: prov.isField8?Theme.of(context).colorScheme.secondary:Theme.of(context).colorScheme.primary,
                    value: prov.isField8, onChanged: (v){
                      prov.changeField8(v);
                  })
                ],
              ),
            ),
          ),

        ],
      ),
    )),);
  }
}