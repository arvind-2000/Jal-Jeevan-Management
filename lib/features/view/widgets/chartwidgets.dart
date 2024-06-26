
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/features/domain/entities/wateracidityentity.dart';
import 'package:waterlevelmonitor/features/domain/entities/waterlevelentity.dart';
import 'package:waterlevelmonitor/features/view/provider/pageselectprovider.dart';
import 'package:waterlevelmonitor/features/view/widgets/cardstyle.dart';

import '../../../core/dummyacidity.dart';
import '../provider/waterlevelprovider.dart';

class ChartWidget extends StatefulWidget {
  const ChartWidget({super.key,
  
  required this.type
  });
  final int type;

  @override
  State<ChartWidget> createState() => _ChartWidgetState();
}

class _ChartWidgetState extends State<ChartWidget> {


  @override
  Widget build(BuildContext context) {
      final prov = Provider.of<WaterLevelProvider>(context);
      final prov2 = Provider.of<PageSelectProvider>(context);
    return MediaQuery.of(context).size.width>1000?Expanded(
      child: Container(
      
          child:Row(
          
            children: [
              WaterLevelChart(prov: prov, type: widget.type),
              const SizedBox(width: 20,),
              WaterFlowchart(prov: prov),
              const SizedBox(width: 20,),
              WaterLevelBarChart(prov: prov, type: widget.type),
              const SizedBox(width: 20,),
              WaterAcidityChart(type: widget.type),
            ],
          )
          // :Column(
          //   children: [
          //  WaterLevelChart(prov: prov, type: widget.type),
          // const SizedBox(height: 20,),

          //          Expanded(
          //            child: CardStyle(
          //              child: Container(
          //               padding:const EdgeInsets.all(16),
          //                child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                  children: [
          //                                                          Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Text('This Year',style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
          //                     SizedBox(height: 20,),
          //                    Text('${prov.avg(prov.monthly(prov.allfixwaterlevellist, DateTime.now()))[0].toStringAsFixed(0)} $levelunit',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
          //                 ],
          //               ),
          //               SizedBox(height: 20,),
          //                    Expanded(
          //                      child: SfCartesianChart(
          //                       zoomPanBehavior: ZoomPanBehavior(
                                              
          //                       enableMouseWheelZooming: true,
          //                       enablePanning: true,
                                
          //                       // maximumZoomLevel: 1,  
          //                       // enablePinching: true,
                                                
          //                       zoomMode: ZoomMode.x,
          //                       enableSelectionZooming: true
                                              
          //                                        ),
          //                                      tooltipBehavior: TooltipBehavior(enable: true,
          //                           builder: (data, point, series, pointIndex, seriesIndex) {
          //                             return Text('${months[prov.yearly(prov.allfixwaterlevellist,DateTime.now())[pointIndex].date.month-1]}\n${data.level} $levelunit',style: TextStyle(color: Theme.of(context).colorScheme.surface,fontSize: 14));
          //                           },
          //                                 color: Theme.of(context).colorScheme.primary,
          //                           textStyle: TextStyle(color: Theme.of(context).colorScheme.surface)
                                    
          //                           ),
          //                                        borderWidth: 0,
                                             
          //                                        borderColor: Colors.transparent,
          //                                        margin: EdgeInsets.zero,
          //                                        plotAreaBorderColor: Colors.transparent,
          //                                        plotAreaBorderWidth: 0,
          //                                        // title: ChartTitle(
          //                                        //   text: prov.graphDataList[0].name,
          //                                        //   alignment: ChartAlignment.near,
          //                                        //   borderWidth: 8
          //                                        // ),
          //                                        enableAxisAnimation: true,
                                                 
                                                 
          //                                        primaryYAxis:const NumericAxis(
          //                            isVisible: false,        
          //                          majorGridLines: MajorGridLines(
                                    
          //                      width: 0
          //                                       ),
          //                                        desiredIntervals: 10,
                                                  
          //                       minimum: 0.0,
          //                       interval: 50,
                                                 
                                
          //                                        ),
          //                                      primaryXAxis: NumericAxis(
                                                 
          //                        majorGridLines:const MajorGridLines(
                                   
          //                      width: 0
          //                                       ),
                                             
          //                                       axisLabelFormatter:(axisLabelRenderArgs) => ChartAxisLabel(  months[prov.yearly(prov.allfixwaterlevellist, DateTime.now())[int.parse(axisLabelRenderArgs.text)].date.month-1],const TextStyle(fontSize:12)) ,
          //                                      interval:1,
          //                                    ),
                                
          //                                    series:[  barcharts(prov.yearly(prov.allfixwaterlevellist, DateTime.now()), 0, Theme.of(context).colorScheme.secondary,widget.type)],
          //                                    ),
          //                    ),

               
          //                  ],
          //                ),
          //              ),
          //            ),
          //          ),
          //   ],
          // )
      ),
    ):prov2.pageswap==0?WaterLevelChart(prov: prov, type: widget.type):prov2.pageswap==1?WaterFlowchart(prov: prov): prov2.pageswap==2?WaterLevelBarChart(prov: prov, type: widget.type):WaterAcidityChart(type: widget.type);
  }
}

class WaterAcidityChart extends StatelessWidget {
  const WaterAcidityChart({
    super.key,
    required this.type,
  });

  final int type;

  @override
  Widget build(BuildContext context) {
     final prov2 = Provider.of<PageSelectProvider>(context);
    return Expanded(
       flex: MediaQuery.of(context).size.width>1000?prov2.graphchangeval==3?4:1:1,
                    child: CardStyle(
                      child: Column(
     children: [
       Expanded(
         
         child: Container(
           // padding:const EdgeInsets.all(16),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
             Padding(
               padding: const EdgeInsets.all(16.0),
               child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Text('This Month',style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),

                            MediaQuery.of(context).size.width<1000?IconButton(onPressed: (){
                                      prov2.changegraphpage();
                              }, icon: Icon(Icons.arrow_forward,size: 12,)):IconButton(onPressed: (){
                                      prov2.graphExpand(3);
                              }, icon: Icon(prov2.graphchangeval==3?FontAwesomeIcons.expandAlt:FontAwesomeIcons.expand,size: 12,))
                       ],
                     ),
                     SizedBox(height:20,),
                     Column(
                       children: [
                         Row(children: [
                           Container(height: 10,
                           width: 20,
                           decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             color: datacolorsacid[0]
                           ),
                           ),
                           Text('Chlorine $chlorine',style: TextStyle(fontSize: 12),)
                         ],),
                             SizedBox(height: 10,),
                           Row(children: [
                           Container(height: 10,
                           width: 20,
                           decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             color: datacolorsacid[2]
                           ),
                           ),
                           Text('Turbidity $turbidity',style: TextStyle(fontSize: 12),)
                         ],),
                         SizedBox(height: 10,),
                           Row(children: [
                           Container(height: 10,
                           width: 20,
                           decoration: BoxDecoration(
                             shape: BoxShape.circle,
                             color: datacolorsacid[1]
                           ),
                           ),
                           Text('PH',style: TextStyle(fontSize: 12),)
                         ],),
                       ],
                     )
               
                     // Text('Acidity',style: TextStyle(fontSize: 20),),
                     // SizedBox(height: 10,),
                     // Text('${wateraciditydummies.last.ph.toStringAsFixed(0)} $levelunit',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                   ],
                 ),
             ),
               Expanded(
                 child: SfCartesianChart(
                       zoomPanBehavior: ZoomPanBehavior(
                  
                       enableMouseWheelZooming: true,
                       enablePanning: true,
                       
                       // maximumZoomLevel: 1,  
                       // enablePinching: true,
                    
                       zoomMode: ZoomMode.x,
                       enableSelectionZooming: true
                  
                     ),
                     // tooltipBehavior: TooltipBehavior(enable: true,
                     // builder: (data, point, series, pointIndex, seriesIndex) {
                     //   return Text('Date ${prov.monthlyacidity(wateraciditydummies,DateTime.now())[pointIndex].dateTime.day}\n${data.level} $levelunit',style: TextStyle(fontSize: 12),);
                     // },
                     // color: Theme.of(context).colorScheme.primary,
                     // textStyle: TextStyle(color: Theme.of(context).colorScheme.surface)
                     // ),
                     borderWidth: 0,
                 
                     borderColor: Colors.transparent,
                     margin: EdgeInsets.zero,
                     plotAreaBorderColor: Colors.transparent,
                     plotAreaBorderWidth: 0,
                     // title: ChartTitle(
                     //   text: prov.graphDataList[0].name,
                     //   alignment: ChartAlignment.near,
                     //   borderWidth: 8
                     // ),
                     enableAxisAnimation: true,
                     
                     
                     primaryYAxis:const NumericAxis(
                   isVisible: false,  
                          majorGridLines: MajorGridLines(
                           
                      width: 0
                    ),
                     desiredIntervals: 10,
                       decimalPlaces: 0,
                       minimum: 0.0,
                       // interval: 50,
                          maximum: 50,
                       
                     ),
                   primaryXAxis: NumericAxis(
                       isVisible: false,  
                        majorGridLines:const MajorGridLines(
                       
                      width: 0
                    ),
            
                   //  axisLabelFormatter:(axisLabelRenderArgs) => ChartAxisLabel(  wateraciditydummies[int.parse(axisLabelRenderArgs.text)].dateTime.day.toString(),const TextStyle(fontSize:12)) ,
                   interval:1,
                 ),
                       
                 series:[ 
                   
                   linechartsd(wateraciditydummies, 0, datacolorsacid[0],type),
                   linechartsd(wateraciditydummies, 1, datacolorsacid[1],type),
                   linechartsd(wateraciditydummies ,2, datacolorsacid[2],type)
                 
                 ],
                 ),
               ),
               
           
    
    
    
             ],
           ),
         ),
       ),
    
                
    
     ],
                      ),
                    ),
                  );
  }
}

class WaterLevelBarChart extends StatelessWidget {
  const WaterLevelBarChart({
    super.key,
    required this.prov,
    required this.type,
  });

  final WaterLevelProvider prov;
  final int type;
  @override
  Widget build(BuildContext context) {
    final prov2 = Provider.of<PageSelectProvider>(context);
    return Expanded(
        flex: MediaQuery.of(context).size.width>1000?prov2.graphchangeval==2?4:1:1,
      child: CardStyle(
        child: Container(
         padding:const EdgeInsets.all(16),
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                                                    Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
                    Row(   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('This Year',style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                               MediaQuery.of(context).size.width<1000?IconButton(onPressed: (){
                                      prov2.changegraphpage();
                              }, icon: Icon(Icons.arrow_forward,size: 12,)):IconButton(onPressed: (){
                                      prov2.graphExpand(2);
                              }, icon: Icon(prov2.graphchangeval==2?FontAwesomeIcons.expandAlt:FontAwesomeIcons.expand,size: 12,))
                            ],
                          ),
               SizedBox(height: 20,),
              Text('${prov.avg(prov.monthly(prov.allfixwaterlevellist, DateTime.now()))[0].toStringAsFixed(0)} $levelunit',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
           ],
         ),
         SizedBox(height: 20,),
              Expanded(
                child: SfCartesianChart(
                 zoomPanBehavior: ZoomPanBehavior(
                               
                 enableMouseWheelZooming:false,
                 enablePanning: false,
                 
                 // maximumZoomLevel: 1,  
                 // enablePinching: true,
                                 
                 zoomMode: ZoomMode.x,
                 enableSelectionZooming: false
                               
                                  ),
                                tooltipBehavior: TooltipBehavior(enable: true,
                     builder: (data, point, series, pointIndex, seriesIndex) {
                       return Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text('${months[prov.yearly(prov.allfixwaterlevellist,DateTime.now())[pointIndex].date.month-1]}\n${data.level} $levelunit',style: TextStyle(color: Theme.of(context).colorScheme.surface,fontSize: 14)),
                       );
                     },
                           color: Theme.of(context).colorScheme.primary,
                     textStyle: TextStyle(color: Theme.of(context).colorScheme.surface)
                     
                     ),
    
                         isTransposed: true,
                                  borderWidth: 0,
                              
                                  borderColor: Colors.transparent,
                                  margin: EdgeInsets.zero,
                                  plotAreaBorderColor: Colors.transparent,
                                  plotAreaBorderWidth: 0,
                                  // title: ChartTitle(
                                  //   text: prov.graphDataList[0].name,
                                  //   alignment: ChartAlignment.near,
                                  //   borderWidth: 8
                                  // ),
                                  enableAxisAnimation: true,
                                  
                                  
                                  primaryYAxis:const NumericAxis(
                      isVisible: false,        
                    majorGridLines: MajorGridLines(
                     
                width: 0
                                 ),
                                  desiredIntervals: 10,
                                   
                 minimum: 0.0,
                 interval: 50,
                                  
                 
                                  ),
                                primaryXAxis: NumericAxis(
                                  
                  majorGridLines:const MajorGridLines(
                    
                width: 0
                                 ),
                              
                                 axisLabelFormatter:(axisLabelRenderArgs) => ChartAxisLabel(  months[prov.yearly(prov.allfixwaterlevellist, DateTime.now())[int.parse(axisLabelRenderArgs.text)].date.month-1],const TextStyle(fontSize:12)) ,
                                interval:1,
                              ),
                 
                              series:[  barcharts(prov.yearly(prov.allfixwaterlevellist, DateTime.now()), 0, Theme.of(context).colorScheme.secondary,type)],
                              ),
              ),
    
                   
            ],
          ),
        ),
      ),
    );
  }
}

class WaterFlowchart extends StatelessWidget {
  const WaterFlowchart({
    super.key,
    required this.prov,
  });

  final WaterLevelProvider prov;

  @override
  Widget build(BuildContext context) {
     final prov2 = Provider.of<PageSelectProvider>(context);
    return Expanded(
        flex: MediaQuery.of(context).size.width>1000?prov2.graphchangeval==1?4:1:1,
      child: CardStyle(
        child: Column(
          children: [
            Expanded(
              child: Container(
                // padding:const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                                  Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('This Month',style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                            MediaQuery.of(context).size.width<1000?IconButton(onPressed: (){
                                      prov2.changegraphpage();
                              }, icon: Icon(Icons.arrow_forward,size: 12,)):IconButton(onPressed: (){
                                      prov2.graphExpand(1);
                              }, icon: Icon(prov2.graphchangeval==1?FontAwesomeIcons.expandAlt:FontAwesomeIcons.expand,size: 12,))
                            ],
                          ),
                          SizedBox(height:20,),
                          Text('Water Flow',style: TextStyle(fontSize: 20),),
                          SizedBox(height: 10,),
                          Text('${prov.monthly(prov.allfixwaterlevellist, DateTime.now()).last.totalflow.toStringAsFixed(0)} $flowunit',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                        ],
                      ),
                  ),
                    Expanded(
                      child: SfCartesianChart(
                            zoomPanBehavior: ZoomPanBehavior(
                       
                            enableMouseWheelZooming: true,
                            enablePanning: true,
                            
                            // maximumZoomLevel: 1,  
                            // enablePinching: true,
                         
                            zoomMode: ZoomMode.x,
                            enableSelectionZooming: true
                       
                          ),
                          tooltipBehavior: TooltipBehavior(enable: true,
                          builder: (data, point, series, pointIndex, seriesIndex) {
                            return Text('Date ${prov.monthly(prov.allfixwaterlevellist,DateTime.now())[pointIndex].date.day}\n${data.level} $flowunit',style: TextStyle(fontSize: 12),);
                          },
                          color: Theme.of(context).colorScheme.primary,
                          textStyle: TextStyle(color: Theme.of(context).colorScheme.surface)
                          ),
                          borderWidth: 0,
                      
                          borderColor: Colors.transparent,
                          margin: EdgeInsets.zero,
                          plotAreaBorderColor: Colors.transparent,
                          plotAreaBorderWidth: 0,
                          // title: ChartTitle(
                          //   text: prov.graphDataList[0].name,
                          //   alignment: ChartAlignment.near,
                          //   borderWidth: 8
                          // ),
                          enableAxisAnimation: true,
                          
                          
                          primaryYAxis:const NumericAxis(
                        isVisible: false,  
                               majorGridLines: MajorGridLines(
                                
                           width: 0
                         ),
                          desiredIntervals: 10,
                            decimalPlaces: 0,
                            minimum: 0.0,
                            interval: 50,
                          
                            
                          ),
                        primaryXAxis: NumericAxis(
                          isVisible: false,
                             majorGridLines:const MajorGridLines(
                               
                           width: 0
                         ),
                      
                         axisLabelFormatter:(axisLabelRenderArgs) => ChartAxisLabel(  prov.monthly(prov.allfixwaterlevellist, DateTime.now())[int.parse(axisLabelRenderArgs.text)].date.day.toString(),const TextStyle(fontSize:12)) ,
                        interval:1,
                      ),
                            
                      series:[  linecharts(prov.monthly(prov.allfixwaterlevellist, DateTime.now()), 0, Theme.of(context).colorScheme.secondary,1)],
                      ),
                    ),
                    
                
    
    
    
                  ],
                ),
              ),
            ),
    
                
    
          ],
        ),
      ),
    );
  }
}

class WaterLevelChart extends StatelessWidget {
  const WaterLevelChart({
    super.key,
    required this.prov,
    required this.type,
  });

  final WaterLevelProvider prov;
  final int type;

  @override
  Widget build(BuildContext context) {
    final prov2 = Provider.of<PageSelectProvider>(context);
    return Expanded(
      flex: MediaQuery.of(context).size.width>1000?prov2.graphchangeval==0?4:1:1,
      child: CardStyle(
        child: Column(
          children: [
            Expanded(
              child: Container(
                // padding:const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('This Month',style: TextStyle(fontSize: 16,color: Theme.of(context).colorScheme.surface.withOpacity(0.6)),),
                            MediaQuery.of(context).size.width<1000?IconButton(onPressed: (){
                                      prov2.changegraphpage();
                              }, icon: Icon(Icons.arrow_forward,size: 12,)):IconButton(onPressed: (){
                                      prov2.graphExpand(0);
                              }, icon: Icon(prov2.graphchangeval==0?FontAwesomeIcons.expandAlt:FontAwesomeIcons.expand,size: 12,))
                            ],
                          ),
                          SizedBox(height:20,),
                          Text('Water Level',style: TextStyle(fontSize: 20),),
                          SizedBox(height: 10,),
                          Text('${prov.monthly(prov.allfixwaterlevellist, DateTime.now()).last.level.toStringAsFixed(0)} $levelunit',style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                        ],
                      ),
                  ),
                    Expanded(
                      child: SfCartesianChart(
                            zoomPanBehavior: ZoomPanBehavior(
                       
                            enableMouseWheelZooming: true,
                            enablePanning: true,
                            
                            // maximumZoomLevel: 1,  
                            // enablePinching: true,
                         
                            zoomMode: ZoomMode.x,
                            enableSelectionZooming: true
                       
                          ),
                          tooltipBehavior: TooltipBehavior(enable: true,
                          builder: (data, point, series, pointIndex, seriesIndex) {
                            return Text('Date ${prov.monthly(prov.allfixwaterlevellist,DateTime.now())[pointIndex].date.day}\n${data.level} $levelunit',style: TextStyle(fontSize: 12),);
                          },
                          color: Theme.of(context).colorScheme.primary,
                          textStyle: TextStyle(color: Theme.of(context).colorScheme.surface)
                          ),
                          borderWidth: 0,
                      
                          borderColor: Colors.transparent,
                          margin: EdgeInsets.zero,
                          plotAreaBorderColor: Colors.transparent,
                          plotAreaBorderWidth: 0,
                          // title: ChartTitle(
                          //   text: prov.graphDataList[0].name,
                          //   alignment: ChartAlignment.near,
                          //   borderWidth: 8
                          // ),
                          enableAxisAnimation: true,
                          
                          
                          primaryYAxis:const NumericAxis(
                        isVisible: false,  
                               majorGridLines: MajorGridLines(
                                
                           width: 0
                         ),
                          desiredIntervals: 10,
                            decimalPlaces: 0,
                            minimum: 0.0,
                            interval: 50,
                          
                            
                          ),
                        primaryXAxis: NumericAxis(
                            isVisible: false,
                             majorGridLines:const MajorGridLines(
                               
                           width: 0
                         ),
                      
                         axisLabelFormatter:(axisLabelRenderArgs) => ChartAxisLabel(  prov.monthly(prov.allfixwaterlevellist, DateTime.now())[int.parse(axisLabelRenderArgs.text)].date.day.toString(),const TextStyle(fontSize:12)) ,
                        interval:1,
                      ),
                            
                      series:[  linecharts(prov.monthly(prov.allfixwaterlevellist, DateTime.now()), 0, Colors.green.withOpacity(0.5),type)],
                      ),
                    ),
                    
                
    
    
    
                  ],
                ),
              ),
            ),
    
                
    
          ],
        ),
      ),
    );
  }
}


  SplineAreaSeries<WaterLevel, int> linecharts(
    List<WaterLevel> waterLevel,
    int index,
    Color color,
    int type
  ) {

  
    return SplineAreaSeries(
        animationDelay: 1,
          animationDuration:1600,
        enableTooltip: true,

        markerSettings: MarkerSettings(
          isVisible: true,
          color:color.withOpacity(0.4),
          shape: DataMarkerType.circle
        ),
        
        borderColor:color,
        borderWidth: 2,
        
        splineType: SplineType.cardinal,
        cardinalSplineTension: 0.3,
        gradient: LinearGradient(
            colors: [color.withOpacity(0.2), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
        dataSource:waterLevel,
        emptyPointSettings: EmptyPointSettings(
          mode: EmptyPointMode.average
          
        ),
        xValueMapper: (datum, index) {
          return index;
        },
      
        yValueMapper: (d, i) =>type==0?d.level:d.totalflow);
  }

ColumnSeries<WaterLevel, int> barcharts(
    List<WaterLevel> waterLevels,
    int index,
    Color color,
    int type
  ) {
    return ColumnSeries(
        animationDelay: 1,
        animationDuration:1600,

        enableTooltip: true,
        trackColor: Colors.grey.withOpacity(0.1),
        
        onPointTap: (c){
        
        },
        width: 0.7,
        isTrackVisible: true,
        spacing: 0.0,
        color:color,
      
    

        // borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
        // splineType: SplineType.natural,
        // gradient: LinearGradient(
        //     colors: [Colors.transparent, Colors.transparent],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter),
        dataSource: waterLevels,
        xValueMapper: (datum, index) {
          return index;
        },
        yValueMapper: (d, i) =>type==0?d.level:d.totalflow);
  }


  SplineAreaSeries<WaterAcidityEntity, int> linechartsd(
    List<WaterAcidityEntity> waterLevel,
    int index,
    Color color,
    int type
  ) {

  
    return SplineAreaSeries(
        animationDelay: 1,
          animationDuration:1600,
        enableTooltip: true,

        markerSettings: MarkerSettings(
          isVisible: true,
          color:color.withOpacity(0.4),
          shape: DataMarkerType.circle
        ),
        
        borderColor:color,
        borderWidth: 2,
        
        splineType: SplineType.cardinal,
        cardinalSplineTension: 0.3,
        gradient: LinearGradient(
            colors: [color.withOpacity(0.2), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
        dataSource:waterLevel,
        emptyPointSettings: EmptyPointSettings(
          mode: EmptyPointMode.average
          
        ),
        xValueMapper: (datum, index) {
          return index;
        },
      
        yValueMapper: (d, i) =>index==0?d.chlorine:index==1?d.ph:d.turbidity);
  }