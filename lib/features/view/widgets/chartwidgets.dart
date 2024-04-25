import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/features/domain/entities/waterlevelentity.dart';

import '../provider/waterlevelprovider.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key,
  
  required this.type
  });
  final int type;
  @override
  Widget build(BuildContext context) {
      final prov = Provider.of<WaterLevelProvider>(context);
    return Expanded(
      child: Container(
        padding:const EdgeInsets.only(
          top:8,
          
          right: 16),
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

                   majorGridLines: MajorGridLines(
                    
               width: 0
             ),
              desiredIntervals: 10,
                decimalPlaces: 0,
                minimum: 0.0,
                interval: 50,
              
                
              ),
            primaryXAxis: NumericAxis(
              
                 majorGridLines:const MajorGridLines(
                   
               width: 0
             ),

             axisLabelFormatter: prov.recordtime==1?(axisLabelRenderArgs) => ChartAxisLabel(  prov.allwaterlevellist[int.parse(axisLabelRenderArgs.text)].date.day.toString(),const TextStyle(fontSize:12)) :prov.recordtime==0?(axisLabelRenderArgs) => ChartAxisLabel(  ' ${prov.allwaterlevellist[int.parse(axisLabelRenderArgs.text)].date.hour.toString()}:${prov.allwaterlevellist[int.parse(axisLabelRenderArgs.text)].date.minute.toString()} ',const TextStyle(fontSize:12)):(axisLabelRenderArgs) => ChartAxisLabel(  months[prov.allwaterlevellist[int.parse(axisLabelRenderArgs.text)].date.month-1],const TextStyle(fontSize:12)) ,
            interval:1,
          ),
      
          series:[  prov.isgraph == 1?barcharts(prov.allwaterlevellist, 0, Theme.of(context).colorScheme.secondary,type):linecharts(prov.allwaterlevellist, 0, Theme.of(context).colorScheme.secondary,type)],
          )
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
        animationDuration: 0.3,
        enableTooltip: true,
        markerSettings: MarkerSettings(
          isVisible: true,
          color:color.withOpacity(0.4),
          borderWidth: 0,
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
        animationDuration: 0.3,
        enableTooltip: true,
        trackColor: Colors.red,
        
        onPointTap: (c){
        
        },
        width: 0.3,
        initialIsVisible: true,
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


