import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:waterlevelmonitor/core/dummy.dart';
import 'package:waterlevelmonitor/features/domain/entities/waterlevelentity.dart';

import '../provider/waterlevelprovider.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
      final prov = Provider.of<WaterLevelProvider>(context);
    return Expanded(
      child: Container(
        padding:const EdgeInsets.only(top:16,bottom: 16,right: 16),
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
      
                minimum: 0.0,
                interval: 50,
                maximum: 100,
                
              ),
            primaryXAxis:const NumericAxis(
                 majorGridLines: MajorGridLines(
                   
               width: 0
             ),
          
          ),
      
          series:[  prov.isgraph == 1?barcharts(waterleveldummy, 0, Theme.of(context).colorScheme.secondary):linecharts(waterleveldummy, 0, Theme.of(context).colorScheme.secondary)],
          )
      ),
    );
  }
}


  SplineAreaSeries<WaterLevel, int> linecharts(
    List<WaterLevel> waterLevel,
    int index,
    Color color,

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
      
        yValueMapper: (d, i) => d.level);
  }

ColumnSeries<WaterLevel, int> barcharts(
    List<WaterLevel> waterLevels,
    int index,
    Color color,
  ) {
    return ColumnSeries(
        animationDelay: 1,
        animationDuration: 0.3,
        enableTooltip: true,
        trackColor: Colors.red,
        onPointTap: (c){
      
        },
        color:color,
        borderColor:color,
        borderWidth: 1,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
        // splineType: SplineType.natural,
        // gradient: LinearGradient(
        //     colors: [Colors.transparent, Colors.transparent],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter),
        dataSource: waterLevels,
        xValueMapper: (datum, index) {
          return index;
        },
        yValueMapper: (d, i) => d.level);
  }

