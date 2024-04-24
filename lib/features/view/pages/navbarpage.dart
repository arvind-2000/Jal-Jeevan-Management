import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/features/view/provider/waterlevelprovider.dart';

import '../widgets/cardoption.dart';

class NavBarPage extends StatelessWidget {
  const NavBarPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<WaterLevelProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(appname,style: TextStyle(fontSize: 24),),
            Row(children: [
              InkWell(
                onTap: (){
                  prov.changeRecord(0);
                },

                child: CardOptionBorder(title: 'Today',isSelect: prov.recordtime==0,)),
                SizedBox(width: 20,),
              InkWell(
                onTap: (){
                  prov.changeRecord(1);
                },
                child: CardOptionBorder(title: 'This Month',isSelect: prov.recordtime == 1,)),
                   SizedBox(width: 20,),
              InkWell(
                onTap: (){
                  prov.changeRecord(2);
                },
                child: CardOptionBorder(title: 'This Year',isSelect: prov.recordtime == 2,)),
            ],)
          ],
        ),
    );
  }
}

