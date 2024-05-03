import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/features/view/pages/graphscreen.dart';
import 'package:waterlevelmonitor/features/view/pages/reportscreen.dart';
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
    prov.init(prov2.allfixwaterlevellist);
    
    return Expanded(
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child:selecprov.pageSelect==2? const GraphScreen():selecprov.filterselect?const FilterPage():CardStyle(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
               Padding(
                    padding:EdgeInsets.all(16),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Records",style: TextStyle(fontSize: 26),),
                        MediaQuery.of(context).size.width>screensize?SizedBox():IconButton(onPressed: (){
                              selecprov.changeFilter();

                        }, icon: FaIcon(FontAwesomeIcons.filter,size: 12,))
                      ],
                    ),
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
                    height: 200,
                    padding: EdgeInsets.all(16),
                    child: Row(
                  
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(prov.timerecord==0?'${prov.currentdate.year}':prov.timerecord==1?'${months[prov.currentdate.month-1]} ${prov.currentdate.year}':getDate(prov.currentdate),style: TextStyle(fontSize: 24),),
                           
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Average'),
                                  SizedBox(height: 20,),
                                    MediaQuery.of(context).size.width<screensize?SizedBox(): Row(
                                  
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Level',style: TextStyle(fontSize: 14,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                                          Text('${prov.avgslevel[0].toStringAsFixed(0)} $levelunit',style: TextStyle(fontSize: 20),),
                                        ],
                                      ),
                                      SizedBox(width: 20,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Flow',style: TextStyle(fontSize: 14,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                                          Text('${prov.avgslevel[1].toStringAsFixed(0)} $flowunit',style: TextStyle(fontSize: 20),),
                                        ],
                                      ),
                                       SizedBox(width: 20,),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('temp',style: TextStyle(fontSize: 14,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                                          Text('${prov.avgslevel[2].toStringAsFixed(0)} $tempunit',style: TextStyle(fontSize: 20),),
                                        ],
                                      ),
                                                
                                                
                                    
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),

                         Container(
                            height: 200,
                            width: 200,
                            child: RadialBarSmall(value: prov.avgslevel))
                      ],
                    )))
              
                ],
              ),
            ),
          ),
          MediaQuery.of(context).size.width<screensize?SizedBox():Expanded(
            
           
            child: FilterPage())
        ],
      ),
    );
  }
}

class RadialBarTables extends StatelessWidget {
  const RadialBarTables({
    super.key,
    required this.value
  });
 final List<double> value;
  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
                  tooltipBehavior: TooltipBehavior(enable: true,
                                  builder: (data, point, series, pointIndex, seriesIndex) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${dataseriesindicator[pointIndex%3]} ${data.roundToDouble()} ${measurementindicator[pointIndex%3]} ',style: TextStyle(color: Theme.of(context).colorScheme.surface,fontSize: 14)),
                                    );
                                  },
                                  color: Theme.of(context).colorScheme.primary,
                        
                                  ),
          series: [DoughnutSeries(

               pointColorMapper: (d,i){
                return datacolors[i%3];
              },
            animationDuration: 800,
            strokeWidth: 0.5,
              // useSeriesColor: true,
              // trackOpacity: 0.3,
              // strokeColor: Theme.of(context).colorScheme.secondary,
            innerRadius:'30',
            // cornerStyle: CornerStyle.bothCurve,    
            xValueMapper: (c,i){
            return i;
          }, yValueMapper:(c,i){
         
            return value[i];
          },
          // maximumValue: 500,
        dataSource: value,
          )],
        );
  }
}