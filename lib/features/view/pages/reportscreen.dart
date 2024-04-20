import 'package:flutter/material.dart';
import 'package:order_tracker/order_tracker.dart';
import 'package:provider/provider.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/features/view/provider/waterlevelprovider.dart';

import '../widgets/cardstyle.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({
    super.key,
  });

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {

   List<TextDto> orderList = [
    TextDto("Your order has been placed", "Fri, 25th Mar '22 - 10:47pm"),
    TextDto("Seller ha processed your order", "Sun, 27th Mar '22 - 10:19am"),
    TextDto("Your item has been picked up by courier partner.", "Tue, 29th Mar '22 - 5:00pm"),
  ];
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
            Expanded(
              child: Row(
                children: [
                 Expanded(
                    flex: 3,
                    child: ListView(
                       shrinkWrap: true,
                       scrollDirection: Axis.horizontal,
                       physics: BouncingScrollPhysics(),
                         children: [
                           Dots(times: '2.8.2024\n12mins',),
                           Dots(times: '2.8.2024\n12mins',),
                           Dots(times: '2.8.2024\n12mins',),
                            Dots(times: '2.8.2024\n12mins',),
                           Dots(times: '2.8.2024\n12mins',),
                           Dots(times: '2.8.2024\n12mins',),
                            Dots(times: '2.8.2024\n12mins',),
                           Dots(times: '2.8.2024\n12mins',),
                           Dots(times: '2.8.2024\n12mins',)
                         ],
                       ),
                  ),
                Expanded(
                  flex: 2,
                  child: CardStyle(child: Padding(
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
                                Text('2 $levelunit',style: TextStyle(fontSize: 20),),
                                Text('2 mins ago'),
                              ],
                            )
                          ],
                        ),
                      Expanded(
                        child: Container(
                                            
                          padding: EdgeInsets.all(16),
                          margin: EdgeInsets.all(16),
                        
                          ),
                      )
                        


                      ],
                    ),
                  )),
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

