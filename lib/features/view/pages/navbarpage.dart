import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/features/view/provider/pageselectprovider.dart';
import 'package:waterlevelmonitor/features/view/provider/waterlevelprovider.dart';



class NavBarPage extends StatelessWidget {
  const NavBarPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectprov = Provider.of<PageSelectProvider>(context);
    final prov = Provider.of<WaterLevelProvider>(context);
    return Container(
      padding:const EdgeInsets.symmetric(horizontal: 16),
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(appname,style: const TextStyle(fontSize: 24),)),

            Expanded(
              child: Row(
                mainAxisAlignment:  MainAxisAlignment.end,
                children: [
                IconButton(
                  onPressed: (){
                    selectprov.changePage(0);
                  },
              
                  icon:FaIcon(FontAwesomeIcons.house,size: 12,color: selectprov.pageSelect==0?Theme.of(context).colorScheme.secondary:null,) ),
                  SizedBox(width: 20,),
                IconButton(
                  onPressed: (){
                    selectprov.changePage(1);
                  },
              
                  icon:FaIcon(FontAwesomeIcons.table,size: 12,color: selectprov.pageSelect==1?Theme.of(context).colorScheme.secondary:null,) ),
                  SizedBox(width: 20,),
                
               Row(
                 children: [
                  Text(prov.isAutomatic?'Automatic':'Manual',style: TextStyle(fontSize: 14),),
                  SizedBox(width: 10,),
                   Switch(
                          
                            hoverColor: prov.isAutomatic?Theme.of(context).colorScheme.secondary:Theme.of(context).colorScheme.primary,
                            activeColor: Theme.of(context).colorScheme.secondary,
                            
                            value: prov.isAutomatic, onChanged: (value){
                              
                             if(value){
                                
                                prov.changepumpSwitch(2,prov.waterlevellist.last);
                             
                                
               
                             } else{
                                  prov.changepumpSwitch(prov.isOnoff?1:0,prov.waterlevellist.last);
                                     
                             }
                        
                            // switchpump();
                          }),
                 ],
               ),
                    //  SizedBox(width: 20,),
              // IconButton(
              //     onPressed: (){
              //      selectprov.changePage(2);
              //     },
              
              //     icon:FaIcon(FontAwesomeIcons.lineChart,size: 12,color: selectprov.pageSelect==2?Theme.of(context).colorScheme.secondary:null,) ),
              ],),
            ),

          //  Expanded(
          //    child: selectprov.pageSelect==0?SizedBox():FadeAnimation(
          //      child: Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         InkWell(
          //           onTap: (){
          //             prov.changeRecord(0);
          //           },
               
          //           child: CardOptionBorder(title: 'Today',isSelect: prov.recordtime==0,)),
          //           SizedBox(width: 20,),
          //         InkWell(
          //           onTap: (){
          //             prov.changeRecord(1);
          //           },
          //           child: CardOptionBorder(title: 'This Month',isSelect: prov.recordtime == 1,)),
          //              SizedBox(width: 20,),
          //         InkWell(
          //           onTap: (){
          //             prov.changeRecord(2);
          //           },
          //           child: CardOptionBorder(title: 'This Year',isSelect: prov.recordtime == 2,)),
          //       ],),
          //    ),
          //  )
          ],
        ),
    );
  }
}

