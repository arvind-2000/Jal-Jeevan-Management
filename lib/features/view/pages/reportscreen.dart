import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/features/view/provider/waterlevelprovider.dart';
import 'package:waterlevelmonitor/features/view/widgets/chartwidgets.dart';

import '../widgets/cardstyle.dart';

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
    return CardStyle(
        child:Container(
          padding:const EdgeInsets.all(16),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         const Text('Pump History'),
         const SizedBox(height: 10,),
            Expanded(
              child: Row(
                children: [
                CardStyle(child: Padding(
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
                              Text('${prov.waterlevellist.last.totalflow.toStringAsFixed(2)} $flowunit',style:const TextStyle(fontSize: 20),),
                             
                            ],
                          )
                        ],
                      ),
             
                      
                
                
                    ],
                  ),
                )),
                            Expanded(
                              child: Container(
                                                 
                                               padding:const EdgeInsets.only(left: 16*2),   
                                                    child:Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                             Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(prov.recordtime==0?'${getDate(prov.currentdate)}\nMinutes':prov.recordtime==1?'${months[prov.currentdate.month-1]} ${prov.currentdate.year}':'${prov.currentdate.year}',textAlign: TextAlign.left,style: TextStyle(fontSize: 12),),
          ),
                                                        const ChartWidget(type: 1,),
                                                      ],
                                                    )
                                                    ),
                            )  
                ],
              ),
            )
          
        ],
      ),
    ));
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

