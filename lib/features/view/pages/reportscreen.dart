import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/features/view/provider/filterprovider.dart';
import 'package:waterlevelmonitor/features/view/provider/pageselectprovider.dart';
import 'package:waterlevelmonitor/features/view/provider/waterlevelprovider.dart';
import 'package:waterlevelmonitor/features/view/widgets/radialbar.dart';


import '../widgets/cardstyle.dart';
import '../widgets/cardstyle2.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({
    super.key,
  });

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<WaterLevelProvider>(context);
    final filterprov = Provider.of<Filterprovider>(context);
    final selecprov = Provider.of<PageSelectProvider>(context);
    return CardStyle(
        child:Container(
          padding:const EdgeInsets.all(16),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        //  const Text('Water Flow'),
        //  const SizedBox(height: 10,),
            Expanded(
              child: Row(
                children: [
                CardStyleII(child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Today',style: TextStyle(),),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text('Total Flow',style: TextStyle(fontSize: 14,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                                  SizedBox(height: 10,),
                              Text('${prov.waterlevellist.last.totalflow.toStringAsFixed(2)} $flowunit',style:const TextStyle(fontSize: 20),),
                             
                            ],
                          )
                        ],
                      ),
             
                      
                
                
                    ],
                  ),
                )),
                SizedBox(width: 20,),
                 Expanded(
                   child: InkWell(
                    onTap: (){
                      filterprov.changeTime(1, prov.allfixwaterlevellist, DateTime.now());
                      selecprov.changePage(1);
                    },
                     child: CardStyle(child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Stack(
                        children: [
                            Positioned(
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              height: 120,
                              width: 120,
                              child: RadialBarSmall(value: prov.avg(prov.monthly(prov.allfixwaterlevellist, DateTime.now())),),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('This Month',style: TextStyle(),),
                                  MediaQuery.of(context).size.width<screensize?SizedBox():Row(
                             
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        Text('Avg Lev',style: TextStyle(fontSize: 14,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                                               SizedBox(height: 10,),
                                          Text('${prov.avg(prov.monthly(prov.allfixwaterlevellist, DateTime.now()))[0].toStringAsFixed(0)} $levelunit',style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                         
                                        ],
                                      ),
                                      SizedBox(width: 30,),
                                         Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        Text('Avg Flow',style: TextStyle(fontSize: 14,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                                               SizedBox(height: 10,),
                                          Text('${prov.avg(prov.monthly(prov.allfixwaterlevellist, DateTime.now()))[1].toStringAsFixed(0)} $flowunit',style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                         
                                        ],
                                      ),
                                      SizedBox(width: 30,),
                                         Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        Text('Avg Temp',style: TextStyle(fontSize: 14,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                                               SizedBox(height: 10,),
                                          Text('${prov.avg(prov.monthly(prov.allfixwaterlevellist, DateTime.now()))[2].toStringAsFixed(0)} $tempunit',style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                         
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                                      
                              
                                         
                                         
                            ],
                          ),
                        ],
                      ),
                                     )),
                   ),
                 ),
                 SizedBox(width: 20,),
            Expanded(
                   child: InkWell(
                    onTap: (){
                        filterprov.changeTime(0, prov.allfixwaterlevellist, DateTime.now());
                      selecprov.changePage(1);
                    },
                     child: CardStyle(child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Stack(
                        children: [
                          Positioned(
                            right: 0,
                            top: 0,
                            bottom: 0,
                            child: Container(
                              height: 120,
                              width: 120,
                              child: ChartBars(value: prov.avg(prov.yearly(prov.allfixwaterlevellist, DateTime.now())),),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('This Year',style: TextStyle(),),
                                     MediaQuery.of(context).size.width<screensize?SizedBox():Row(
                             
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        Text('Avg Lev',style: TextStyle(fontSize: 14,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                                          SizedBox(height: 10,),
                                          Text('${prov.avg(prov.yearly(prov.allfixwaterlevellist, DateTime.now()))[0].toStringAsFixed(0)} $levelunit',style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                         
                                        ],
                                      ),
                                      SizedBox(width: 30,),
                                         Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        Text('Avg Flow',style: TextStyle(fontSize: 14,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                                              SizedBox(height: 10,),
                                         Text('${prov.avg(prov.yearly(prov.allfixwaterlevellist, DateTime.now()))[1].toStringAsFixed(0)} $flowunit',style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                         
                                        ],
                                      ),
                                      SizedBox(width: 30,),
                                         Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                        Text('Avg Temp',style: TextStyle(fontSize: 14,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                                              SizedBox(height: 10,),
                                          Text('${prov.avg(prov.yearly(prov.allfixwaterlevellist, DateTime.now()))[2].toStringAsFixed(0)} $tempunit',style:const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                         
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                                      
                              
                                         
                                         
                            ],
                          ),
                        ],
                      ),
                                     )),
                   ),
                 ),
                ],
              ),
            )
          
        ],
      ),
    ));
  }
}

class RadialBarSmall extends StatelessWidget {
  const RadialBarSmall({
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


class ChartBars extends StatelessWidget {
  const ChartBars({
    super.key,
    required this.value
  });
 final List<double> value;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: SfCartesianChart(
            isTransposed: true,
            plotAreaBorderWidth: 0,
          
            primaryXAxis: NumericAxis(
              isVisible: false,
             
            ),
                  tooltipBehavior: TooltipBehavior(enable: true,
                                  builder: (data, point, series, pointIndex, seriesIndex) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('${dataseriesindicator[pointIndex%3]} ${data.roundToDouble()} ${measurementindicator[pointIndex%3]} ', style: TextStyle(color: Theme.of(context).colorScheme.surface,fontSize: 14)),
                                    );
                                  },

                                      color: Theme.of(context).colorScheme.primary,
                                
                                  ),
            primaryYAxis: NumericAxis(
              isVisible: false,
              maximum: 200,
            ),
            series: [BarSeries(
              
              pointColorMapper: (d,i){
                return datacolors[i%3];
              },
             
              animationDuration: 800,
                            
           
            
      
              xValueMapper: (c,i){
              return i;
            }, yValueMapper:(c,i){
           
              return value[i];
            },
          dataSource: value,
            )],
          ),
    );
  }
}


class Dots extends StatelessWidget {
  const Dots({
    super.key,
    required this.times
  });
  final String times;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: CardStyle(

        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(times,style: const TextStyle(fontSize: 12),textAlign: TextAlign.center,),
              const SizedBox(height: 10,),
              Container(
              
                height: 10,
                width: 10,
                decoration:const BoxDecoration(
                  color: Colors.blue,
                shape: BoxShape.circle
          
                ),
              ),
             
             
            ],
          ),
        ),
      ),
    );
  }
}

