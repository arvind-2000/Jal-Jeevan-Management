import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RadialBarScreen extends StatelessWidget {
  const RadialBarScreen({
    super.key,
    required this.waterLevellist,
  });

  final double waterLevellist;

  @override
  Widget build(BuildContext context) {
    log('${waterLevellist}');
    return SfCircularChart(
    
      series: [RadialBarSeries(
        animationDuration: 800,
        strokeWidth: 0.5,
          useSeriesColor: true,
          trackOpacity: 0.3,
        innerRadius:'60',
      
        xValueMapper: (c,i){
        return i;
      }, yValueMapper:(c,i){
     
        return waterLevellist;
      },
      maximumValue: 500,
    dataSource: [waterLevellist],
      )],
    );
  }
}