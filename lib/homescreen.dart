import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:waterlevelmonitor/core/animations/fadeamimation.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/core/error/errorscreen.dart';
import 'package:waterlevelmonitor/features/view/pages/tablescreen.dart';
import 'package:waterlevelmonitor/features/view/provider/pageselectprovider.dart';
import 'features/view/pages/graphscreen.dart';
import 'features/view/pages/reportscreen.dart';
import 'features/view/provider/waterlevelprovider.dart';
import 'features/view/pages/navbarpage.dart';
import 'features/view/pages/waterlevelinfo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<WaterLevelProvider>(context, listen: false).getDatass();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<WaterLevelProvider>(context);
    final selectprov = Provider.of<PageSelectProvider>(context);
    return LayoutBuilder(builder: (context, constraint) {
      double size = MediaQuery.of(context).size.width;
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: size<screensize? AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: Text(appname,style: const TextStyle(fontSize: 24),),
          centerTitle: true,
        ):null,
        drawer:size<screensize? Drawer(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100,),
                 InkWell(
                  onTap: (){
                         selectprov.changePage(0);
                           Navigator.pop(context);
                  },
                   child: Container(
                      padding: EdgeInsets.all(16),
                     child: Row(
                       children: [
                     
                        
                              FaIcon(FontAwesomeIcons.house,size: 12,color: selectprov.pageSelect==0?Theme.of(context).colorScheme.secondary:null,) ,
                              SizedBox(width: 10,),
                              Text('Home',style: TextStyle(color: selectprov.pageSelect==0?Theme.of(context).colorScheme.secondary:null,),)
                     
                       ],
                     ),
                   ),
                 ),
                      SizedBox(width: 20,),
                InkWell(
                  onTap: (){
                         selectprov.changePage(1);
                           Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                     
                          
                         FaIcon(FontAwesomeIcons.table,size: 12,color: selectprov.pageSelect==1?Theme.of(context).colorScheme.secondary:null,) ,
                       SizedBox(width: 10,),
                              Text('Reports',style: TextStyle(color: selectprov.pageSelect==1?Theme.of(context).colorScheme.secondary:null,),)
                      
                      ],
                    ),
                  ),
                ),
                      const SizedBox(width: 20,),
                       InkWell(
                  onTap: (){
                         selectprov.changePage(2);
                         Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      children: [
                     
                          
                         FaIcon(FontAwesomeIcons.gear,size: 12,color: selectprov.pageSelect==2?Theme.of(context).colorScheme.secondary:null,) ,
                       SizedBox(width: 10,),
                              Text('Settings',style: TextStyle(color: selectprov.pageSelect==2?Theme.of(context).colorScheme.secondary:null,),)
                      
                      ],
                    ),
                  ),
                ),
                      const SizedBox(width: 20,),
            ],
          ),
        ):null,
        body: SafeArea(
            child:prov.checkdata?
                
                SizedBox(
                    child: Row(
                      children: [
                        SizedBox(
                          width: size > 1400 ? 80 : 0,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                             size>screensize?const NavBarPage():const SizedBox(),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: size > screensize
                                      ? SingleChildScrollView(

                                        physics:const BouncingScrollPhysics(),
                                        child:SizedBox(
                                          height:MediaQuery.of(context).size.height<500? 600:670,
                                          child: Row(
                                              children: [
                                              const WaterLevelInfo(),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Expanded(
                                                    child: SizedBox(
                                                  width: double.infinity,
                                                  height: double.infinity,
                                                  child: selectprov.pageSelect == 0
                                                      ? FadeAnimation(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                height: 50,
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            8),
                                                                child:
                                                                    AnimatedTextKit(
                                                                  isRepeatingAnimation:
                                                                      true,
                                                                  repeatForever:
                                                                      true,
                                                                  animatedTexts: [
                                                                    FadeAnimatedText(
                                                                        'Today                Level: ${prov.waterlevellist.last.level.roundToDouble()} $levelunit                flow: ${prov.waterlevellist.last.flow.roundToDouble()} $flowunit                temp: ${prov.waterlevellist.last.temp.roundToDouble()} $tempunit',
                                                                        // alignment:
                                                                        //     Alignment
                                                                        //         .topLeft,
                                                                        textStyle:
                                                                            TextStyle(
                                                                                fontSize:
                                                                                    14),
                                                                        duration: Duration(
                                                                            seconds:
                                                                                4)),
                                                                    FadeAnimatedText(
                                                                      'This Month                Level: ${prov.avg(prov.monthly(prov.allfixwaterlevellist, DateTime.now()))[0].roundToDouble()} $levelunit                flow: ${prov.avg(prov.monthly(prov.allfixwaterlevellist, DateTime.now()))[1].roundToDouble()} $flowunit                temp: ${prov.avg(prov.monthly(prov.allfixwaterlevellist, DateTime.now()))[2].roundToDouble()} $tempunit',
                                                                      //  alignment: Alignment.topLeft,
                                                                      duration:
                                                                          Duration(
                                                                              seconds:
                                                                                  4),
                                                                      textStyle:
                                                                          TextStyle(
                                                                              fontSize:
                                                                                  14),
                                                                    ),
                                                                    FadeAnimatedText(
                                                                      'This Year                Level: ${prov.avg(prov.yearly(prov.allfixwaterlevellist, DateTime.now()))[0].roundToDouble()} $levelunit                flow: ${prov.avg(prov.yearly(prov.allfixwaterlevellist, DateTime.now()))[1].roundToDouble()} $flowunit                temp: ${prov.avg(prov.yearly(prov.allfixwaterlevellist, DateTime.now()))[2].roundToDouble()} $tempunit',
                                                                      // alignment:
                                                                      //     Alignment
                                                                      //         .topLeft,
                                                                      duration:
                                                                          Duration(
                                                                              seconds:
                                                                                  4),
                                                                      textStyle:
                                                                          TextStyle(
                                                                              fontSize:
                                                                                  14),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  flex: 4,
                                                                  child:
                                                                      GraphScreen()),
                                                              SizedBox(
                                                                height: 20,
                                                              ),
                                                              Expanded(
                                                                  flex: 2,
                                                                  child:
                                                                      ReportScreen())
                                                            ],
                                                          ),
                                                        )
                                                      : const FadeAnimation(
                                                          child: TableScreen()),
                                                )),
                                              ],
                                            ),
                                        ),
                                      )
                                      : selectprov.pageSelect==0?SingleChildScrollView(
                                        child: Container(
                                          height:selectprov.pageSelect==1?MediaQuery.of(context).size.height:1300,
                                          child:Column(
                                              children: [
                                               selectprov.pageSelect==1?SizedBox(): SizedBox(
                                                height: 1300*0.5,
                                                child: WaterLevelInfo()),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                 SizedBox(
                                                                                                     // width: double.infinity,
                                                                                                     // height: double.infinity,
                                                                                                     child: FadeAnimation(
                                                       child: Column(
                                                         crossAxisAlignment:
                                                             CrossAxisAlignment
                                                                 .start,
                                                         children: [
                                                           Container(
                                                             height: 30,
                                                             margin: EdgeInsets
                                                                 .symmetric(
                                                                     vertical:
                                                                        16),
                                                             child:
                                                                 AnimatedTextKit(
                                                               isRepeatingAnimation:
                                                                   true,
                                                               repeatForever:
                                                                   true,
                                                               animatedTexts: [
                                                                 FadeAnimatedText(
                                                                     'Today    Level: ${prov.waterlevellist.last.level.roundToDouble()} $levelunit    flow: ${prov.waterlevellist.last.flow.roundToDouble()} $flowunit    temp: ${prov.waterlevellist.last.temp.roundToDouble()} $tempunit',
                                                                     // alignment:
                                                                     //     Alignment
                                                                     //         .topLeft,
                                                                     textStyle:
                                                                         TextStyle(
                                                                             fontSize:
                                                                                 14),
                                                                     duration: Duration(
                                                                         seconds:
                                                                             4)),
                                                                 FadeAnimatedText(
                                                                   'This Month    Level: ${prov.avg(prov.monthly(prov.allfixwaterlevellist, DateTime.now()))[0].roundToDouble()} $levelunit    flow: ${prov.avg(prov.monthly(prov.allfixwaterlevellist, DateTime.now()))[1].roundToDouble()} $flowunit    temp: ${prov.avg(prov.monthly(prov.allfixwaterlevellist, DateTime.now()))[2].roundToDouble()} $tempunit',
                                                                   //  alignment: Alignment.topLeft,
                                                                   duration:
                                                                       Duration(
                                                                           seconds:
                                                                               4),
                                                                   textStyle:
                                                                       TextStyle(
                                                                           fontSize:
                                                                               14),
                                                                 ),
                                                                 FadeAnimatedText(
                                                                   'This Year    Level: ${prov.avg(prov.yearly(prov.allfixwaterlevellist, DateTime.now()))[0].roundToDouble()} $levelunit    flow: ${prov.avg(prov.yearly(prov.allfixwaterlevellist, DateTime.now()))[1].roundToDouble()} $flowunit    temp: ${prov.avg(prov.yearly(prov.allfixwaterlevellist, DateTime.now()))[2].roundToDouble()} $tempunit',
                                                                   // alignment:
                                                                   //     Alignment
                                                                   //         .topLeft,
                                                                   duration:
                                                                       Duration(
                                                                           seconds:
                                                                               4),
                                                                   textStyle:
                                                                       TextStyle(
                                                                           fontSize:
                                                                               14),
                                                                 ),
                                                               ],
                                                             ),
                                                           ),
                                                           Container(
                                                            height: 1300*0.25,
                                                            child: GraphScreen()),
                                                           SizedBox(
                                                             height: 20,
                                                           ),
                                                          Container(
                                                               height:1300*0.15,
                                                               child:
                                                                   ReportScreen())
                                                         ],
                                                       ),
                                                     )
                                                   ,
                                                                                                   ),
                                              ],
                                            ),
                                        ),
                                      ):FadeAnimation(child: TableScreen()),
                                ),
                              ),
                              // SizedBox(
                              //   height: 30,
                              // )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size > 1400 ? 80 : 0,
                        ),
                      ],
                    ),
                  ):ErrorScreen()),
      );
    });
  }
}
