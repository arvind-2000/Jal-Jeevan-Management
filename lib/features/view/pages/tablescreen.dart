import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:waterlevelmonitor/features/view/provider/waterlevelprovider.dart';
import 'package:waterlevelmonitor/features/view/widgets/cardstyle.dart';

class TableScreen extends StatelessWidget {
  const TableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<WaterLevelProvider>(context);
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Water Consumption"),
                Expanded(
                  child: SingleChildScrollView(
                    child: Expanded(
                      child: Column(
                        children: [
                          
                                    ListView(
                                  shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    children:prov.allwaterlevellist.map((e) => CardStyle(child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(e.level.toStringAsFixed(0)),
                                    ))).toList(),
                                                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            
            flex: 2,
            child: Container())
        ],
      ),
    );
  }
}