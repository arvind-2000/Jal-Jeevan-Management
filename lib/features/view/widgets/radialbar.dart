import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../domain/entities/waterlevelentity.dart';

class RadialBarScreen extends StatelessWidget {
  const RadialBarScreen({
    super.key,
    required this.waterLevellist,
  });

  final List<WaterLevel> waterLevellist;

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
    
      series: [RadialBarSeries(
        strokeWidth: 0.5,
          useSeriesColor: true,
          trackOpacity: 0.3,
        innerRadius:'60',
      
        xValueMapper: (c,i){
        return i;
      }, yValueMapper:(c,i){
        return waterLevellist[i].level;
      },
      maximumValue: 100,
      dataSource: [waterLevellist.last.level],
      )],
    );
  }
}