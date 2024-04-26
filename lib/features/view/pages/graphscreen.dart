import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/features/view/pages/tablescreen.dart';
import 'package:waterlevelmonitor/features/view/provider/waterlevelprovider.dart';
import 'package:waterlevelmonitor/features/view/widgets/chartwidgets.dart';
import 'package:waterlevelmonitor/features/view/widgets/progress.dart';

import '../widgets/cardstyle.dart';

class GraphScreen extends StatelessWidget {
  const GraphScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<WaterLevelProvider>(context);
    return CardStyle(
        child: Container(
      padding: const EdgeInsets.all(16),
      width: double.infinity,
      height: double.infinity,
      child:prov.allwaterlevellist.isEmpty?const Center(child: Text('No Data'),): Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Water Levels'),
              Row(
                children: [
                  // IconButton(
                  //     tooltip: 'Tables',
                  //     onPressed: () {
                  //       prov.changeGraph(2);
                  //     },
                  //     icon:FaIcon(
                  //       FontAwesomeIcons.table,
                  //       size: 14,
                  //       color: prov.isgraph == 2?Theme.of(context).colorScheme.secondary:null,

                  //     )),
                  IconButton(
                      tooltip: 'Bar',
                      onPressed: () {
                        prov.changeGraph(1);
                      },
                      icon:  FaIcon(
                        FontAwesomeIcons.chartArea,
                        size: 14,
                        color: prov.isgraph == 1?Theme.of(context).colorScheme.secondary:null,
                      )),
                  IconButton(
                      tooltip: 'Line',
                      onPressed: () {
                          prov.changeGraph(0);
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.lineChart,
                        size: 14,
                        color: prov.isgraph == 0?Theme.of(context).colorScheme.secondary:null,
                      )),
                ],
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(prov.recordtime==0?'${getDate(prov.currentdate)}\nMinutes':prov.recordtime==1?'${months[prov.currentdate.month-1]} ${prov.currentdate.year}':'${prov.currentdate.year}',textAlign: TextAlign.left,style: TextStyle(fontSize: 14),),
          ),

         prov.isgraph==2?const TableScreen():const ChartWidget(type: 0,)
        ],
      ),
    ));
  }
}
