import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/core/dummyacidity.dart';

import 'package:waterlevelmonitor/features/view/provider/waterlevelprovider.dart';
import 'package:waterlevelmonitor/features/view/widgets/progress.dart';

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
    _fadecontroller = AnimationController(vsync: this,duration: const Duration(milliseconds: 1000));
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
    return LayoutBuilder(
      builder: (context,constraint) {
        double size = constraint.maxWidth;
        return CardStyle(child:SizedBox(
          width:size>=screensize?350:null,
        
        
          child:prov.isLoading?const ProgressController():Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                // height: prov.isOnoff?160:150,
              padding:const EdgeInsets.all(16),
              color:prov.isOnoff?Colors.green[700]:Theme.of(context).colorScheme.secondary.withOpacity(0.5),
              
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(prov.isOnoff?'Pump is On':'Pump is Off',style:const TextStyle(fontSize: 18,),),
                  
                  
                        ],
                      ),
                    Switch(

                        activeTrackColor: Colors.white,
                        activeColor: Theme.of(context).colorScheme.secondary,
                          inactiveThumbColor: Colors.grey.shade500,
                        inactiveTrackColor: Colors.grey.shade300,
                        hoverColor: prov.isOnoff?Theme.of(context).colorScheme.secondary:Theme.of(context).colorScheme.primary,
                      
                        value: prov.isOnoff, onChanged:prov.isAutomatic?null:(value){
                        prov.switches(value);
                        prov.changepumpSwitch(value?1:0,prov.waterlevellist.last,prov.isField8?1:0,prov.waterlevellist.last.elevation);
                        switchpump();
                      }),
                    ],
                  ),

                   Row(
                     children: [
                      Text(prov.isAutomatic?'Automatic':'Manual',style: TextStyle(fontSize: 14),),
                      const SizedBox(width: 5,),
                       SizedBox(
                        height: 50,
                        width: 50,
                         child: Switch(
                                  
                                  hoverColor: prov.isAutomatic?Theme.of(context).colorScheme.secondary:Theme.of(context).colorScheme.primary,
                                  activeTrackColor: Colors.white,
                                  activeColor: Theme.of(context).colorScheme.secondary,
                                  inactiveThumbColor: Colors.green,
                                  inactiveTrackColor: Colors.grey.shade300,
                                  
                                  value: prov.isAutomatic, onChanged: (value){
                                    
                                   if(value){
                                      
                                      prov.changepumpSwitch(2,prov.waterlevellist.last,prov.isField8?1:0,prov.waterlevellist.last.elevation);
                                   
                                      
                                            
                                   } else{
                                        prov.changepumpSwitch(prov.isOnoff?1:0,prov.waterlevellist.last,prov.isField8?1:0,prov.waterlevellist.last.elevation);
                                           
                                   }
                              
                                  // switchpump();
                                }),
                       ),
                     ],
                   ),
                  // const SizedBox(height: 10,),
                  // !prov.isOnoff?FadeAnimation(
                  //   child: Row(
                  //     children: [
                  //       InkWell(
                  //         onTap: (){
                  //           prov.changeTimeSchedule(5, 0);
                  //         },
                  //         child: CardOptionBorder(title: '5 mins', isSelect:prov.selecTimeSchedule!=0)),
                  //         SizedBox(width: 10,),
                  //              InkWell(
                  //         onTap: (){
                  //           prov.changeTimeSchedule(10, 1);
                  //         },
                  //         child: CardOptionBorder(title: '10 mins', isSelect:prov.selecTimeSchedule!=1)),
                  //         SizedBox(width: 10,),
                  //         InkWell(
                  //         onTap: (){
                  //           prov.changeTimeSchedule(20, 2);
                  //         },
                  //         child: CardOptionBorder(title: '20 mins', isSelect:prov.selecTimeSchedule!=2)),
                  //     ],
                  //   ),
                  // ):const SizedBox(),
                  // const SizedBox(height: 10,),
                    //           prov.isOnoff?Countdown(
                    //   seconds:prov.timeschedule,
                    //   build: (BuildContext context, double time) => Text('${time.toStringAsFixed(0)} seconds',style: const TextStyle(fontSize: 35),),
                    //   interval: const Duration(seconds: 1),
                    
                    //   onFinished: () {
                    //     // prov.switches(false);
                    //     print('Timer is done!');
                    //   },
                    // ):SizedBox()

          

                ],
              ),
              
              ),
                    
              Expanded(
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
                          child: RadialBarScreen(waterLevellist:prov.waterlevellist.first.level,),
                        )
                    
                    
                    ],
                  ),
                ),
              ),
              Divider(
                  color: Theme.of(context).colorScheme.surface.withOpacity(0.4),
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
                        Text("${prov.waterlevellist.last.flow.toStringAsFixed(0)} $flowunit",style:const TextStyle(fontSize: 16),)
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
                        Text("${prov.waterlevellist.last.temp.toStringAsFixed(0)} $tempunit",style:const TextStyle(fontSize: 16),)
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
                            Text("Chlorine",style:TextStyle(fontSize:16,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                          ],
                        ),
                        Text("${wateraciditydummies.last.chlorine.toStringAsFixed(0)} $chlorine",style:const TextStyle(fontSize: 16),)
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
                            Text("Ph Level",style:TextStyle(fontSize:16,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                          ],
                        ),
                        Text("${wateraciditydummies.last.ph.toStringAsFixed(0)} $ph",style:const TextStyle(fontSize: 16),)
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
                            Text("Turbidity",style:TextStyle(fontSize:16,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                          ],
                        ),
                        Text("${wateraciditydummies.last.turbidity.toStringAsFixed(0)} $turbidity",style:const TextStyle(fontSize: 16),)
                      ],
                    ),
                    // const SizedBox(height: 40,),
                   
                  ],
                ),
              ),
                    
            ],
          ),
        ));
      }
    );
  }
}

