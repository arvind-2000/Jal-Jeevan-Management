import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/features/view/pages/graphscreen.dart';
import 'package:waterlevelmonitor/features/view/provider/pageselectprovider.dart';
import 'package:waterlevelmonitor/features/view/provider/waterlevelprovider.dart';
import 'package:waterlevelmonitor/features/view/widgets/cardstyle.dart';
import 'package:waterlevelmonitor/features/view/widgets/filterpage.dart';

import '../provider/filterprovider.dart';

class TableScreen extends StatelessWidget {
  const TableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Filterprovider>(context);
    final prov2 = Provider.of<WaterLevelProvider>(context);
    final selecprov = Provider.of<PageSelectProvider>(context);
    prov.init(prov2.allwaterlevellist);
    
    return Expanded(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child:selecprov.pageSelect==2? const GraphScreen():CardStyle(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 const Padding(
                    padding:EdgeInsets.all(16),
                    child:Text("Records",style: TextStyle(fontSize: 26),),
                  ),
                  SizedBox(height:10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Expanded(
                      
                          child: Column(
                            children: [ 
                                      const Padding(
                                        padding:EdgeInsets.all(8.0),
                                        child: Row(
                                          children: [
                                                  Expanded(child: Text('Date')),
                                                  Expanded(child: Text('level')),
                                                  Expanded(child: Text('flow')),
                                                  Expanded(child: Text('totalf')),
                                                  Expanded(child: Text('temp')),
                                           
                                          ],
                                        ),
                                      ),
                                        ListView(
                                      shrinkWrap: true,
                                        physics:const NeverScrollableScrollPhysics(),
                                        children:prov.filterlist.map((e) => Container(
                                          padding: EdgeInsets.symmetric(vertical: 8),
                                          child: CardStyle(child: Padding(
                                            
                                            
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Expanded(child: Text(getDate(e.date))),
                                              
                                                Expanded(child: Text(e.level.toStringAsFixed(0))),
                                                Expanded(child: Text(e.flow.toStringAsFixed(0))),
                                                Expanded(child: Text(e.totalflow.toStringAsFixed(0))),
                                                Expanded(child: Text(e.temp.toStringAsFixed(0))),
                                               
                                              ],
                                            ),
                                          )),
                                        )).toList(),
                                                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  CardStyle(child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(prov.timerecord==0?'${prov.currentdate.year}':prov.timerecord==1?'${months[prov.currentdate.month-1]} ${prov.currentdate.year}':getDate(prov.currentdate),style: TextStyle(fontSize: 24),),
                        SizedBox(height: 10,),
                        Text('Average'),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Level'),
                                Text('${prov.avgslevel[0].toStringAsFixed(0)} $levelunit',style: TextStyle(fontSize: 20),),
                              ],
                            ),
                            SizedBox(width: 20,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Flow'),
                                Text('${prov.avgslevel[1].toStringAsFixed(0)} $flowunit',style: TextStyle(fontSize: 20),),
                              ],
                            ),
                             SizedBox(width: 20,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('temp'),
                                Text('${prov.avgslevel[2].toStringAsFixed(0)} $tempunit',style: TextStyle(fontSize: 20),),
                              ],
                            )
                          ],
                        )
                      ],
                    )))
              
                ],
              ),
            ),
          ),
          Expanded(
            
           
            child: FilterPage())
        ],
      ),
    );
  }
}