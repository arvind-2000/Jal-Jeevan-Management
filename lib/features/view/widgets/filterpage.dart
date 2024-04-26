import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/features/view/provider/filterprovider.dart';
import 'package:waterlevelmonitor/features/view/provider/waterlevelprovider.dart';
import 'package:waterlevelmonitor/features/view/widgets/cardoption.dart';
import 'package:waterlevelmonitor/features/view/widgets/cardstyle.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<Filterprovider>(context);
    final prov2 = Provider.of<WaterLevelProvider>(context);
    return Container(
      padding: EdgeInsets.only(left: 16),
      child: CardStyle(child:
      Container(
        padding: EdgeInsets.all(16),
        child: Expanded(child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Filter'),
              ],
            ),

    SizedBox(height: 20,),

              Text('Year'),
                  SizedBox(height: 10,),
                  GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,
              childAspectRatio: 2/0.8
              
              ),
              children:List.generate(DateTime.now().year - 2023, (index) => Padding(
                padding: const EdgeInsets.only(right: 16),
                child: InkWell(
                
                  child: CardOptionBorder(title: '${2024+index}', isSelect: prov.currentdate.year==2024+index)),
              ))
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      prov.changeTime(0,prov2.allfixwaterlevellist,prov.currentdate);
                    },
                    child: Text('Month',style: TextStyle(color: prov.timerecord==0?Theme.of(context).colorScheme.secondary:null),)),
                  SizedBox(width: 10,),
                  InkWell(
                    onTap: (){
                      prov.changeTime(1,prov2.allfixwaterlevellist,prov.currentdate);
                    },
                    child: Text('Days',style: TextStyle(color: prov.timerecord==1?Theme.of(context).colorScheme.secondary:null),)),
                         SizedBox(width: 10,),
      
                ],
              ),
              SizedBox(height: 10,),
              GridView(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,
                mainAxisSpacing: 2,
              childAspectRatio: 2/0.8
              
              ),
              children:prov.filterlist.map((e) => Padding(
                padding: const EdgeInsets.only(right: 16),
                child: InkWell(
                onTap: (){
                    if(prov.timerecord == 0){
                   
                      prov.changeTime(1, prov2.allfixwaterlevellist, e.date);
                    }

                },
                  child: CardOptionBorder(title:prov.timerecord==0?months[e.date.month-1]:'${e.date.day}', isSelect:prov.timerecord==1?prov.currentdate.month==e.date.month:false)),
              )).toList(),
              ),
              SizedBox(height: 20,),
     


          ],
        )),
      )  
    
    ));
  }
}