import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waterlevelmonitor/core/const.dart';

import 'package:waterlevelmonitor/features/view/provider/waterlevelprovider.dart';

import '../widgets/cardstyle.dart';
import '../widgets/radialbar.dart';

class WaterLevelInfo extends StatefulWidget {
  const WaterLevelInfo({
    super.key,
  });

  @override
  State<WaterLevelInfo> createState() => _WaterLevelInfoState();
}

class _WaterLevelInfoState extends State<WaterLevelInfo> with TickerProviderStateMixin {
  late AnimationController _fadecontroller;
  late Animation<double> fade;

  @override
  void initState() {
    super.initState();
    _fadecontroller = AnimationController(vsync: this,duration: Duration(milliseconds: 1000));
    fade = Tween<double>(begin: 0,end: 1).animate(_fadecontroller);

  }

  @override
  void dispose() {
    super.dispose();
    _fadecontroller.dispose();
  }
    void switchpump(){
        if(_fadecontroller.isDismissed){
          _fadecontroller.forward();
        }else{
          _fadecontroller.reverse();
        }

    }
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<WaterLevelProvider>(context);
    return CardStyle(child:SizedBox(
      width: 400,
      height: double.infinity,

      child: Column(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            height: prov.isOnoff?159:100,
          padding: EdgeInsets.all(16),
          color:prov.isOnoff?Colors.green[700]:Theme.of(context).colorScheme.secondary,
          
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(prov.isOnoff?'Pump is On':'Pump is Off',style:const TextStyle(fontSize: 18,),),
                      Text('12 mins',style:TextStyle(fontSize: 14,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
              
                    ],
                  ),
                  Switch(
                    splashRadius: 6,
              
                    hoverColor: prov.isOnoff?Theme.of(context).colorScheme.secondary:Theme.of(context).colorScheme.primary,
                    value: prov.isOnoff, onChanged: (value){
                    prov.switches();
                    switchpump();
                  }),
                ],
              ),
              prov.isOnoff?FadeTransition(
                opacity: fade,
                child: Text('12:24',style: TextStyle(fontSize: 40),)):SizedBox()
            ],
          ),
          
          ),

          Expanded(
            flex: 1,
            child: SizedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20,),
                  Text("Water Level",style:TextStyle(fontSize:18,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                  Text("${prov.waterlevellist.last.level.toStringAsFixed(0)} $levelunit",style:const TextStyle(fontSize:24),),
                  
                    Container(
                      height: 200,
                      width: 200,
                      child: RadialBarScreen(waterLevellist: prov.waterlevellist,),
                    )


                ],
              ),
            ),
          ),
          Divider(
              color: Colors.grey.withOpacity(0.1),
              height: 0.2,


          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.levelUp,size: 12,),
                        SizedBox(width: 10,),
                        Text("Level",style:TextStyle(fontSize:16,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                      ],
                    ),
                    Text("${prov.waterlevellist.last.level.toStringAsFixed(0)} $levelunit",style:const TextStyle(fontSize: 16),)
                  ],
                ),
                SizedBox(height: 20,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.water,size: 12,),
                        SizedBox(width: 10,),
                        Text("Flow",style:TextStyle(fontSize:16,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                      ],
                    ),
                    Text("${prov.waterlevellist.last.level.toStringAsFixed(0)} $flowunit",style:const TextStyle(fontSize: 16),)
                  ],
                ),
                SizedBox(height: 20,),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FaIcon(FontAwesomeIcons.temperatureFull,size: 12,),
                        SizedBox(width: 10,),
                        Text("Temp",style:TextStyle(fontSize:16,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                      ],
                    ),
                    Text("${prov.waterlevellist.last.level.toStringAsFixed(0)} $tempunit",style:const TextStyle(fontSize: 16),)
                  ],
                ),
                const SizedBox(height: 40,),
               
              ],
            ),
          ),

        ],
      ),
    ));
  }
}

