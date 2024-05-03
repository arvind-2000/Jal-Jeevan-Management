import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterlevelmonitor/core/animations/fadeamimation.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/core/error/errorscreen.dart';
import 'package:waterlevelmonitor/features/view/pages/tablescreen.dart';
import 'package:waterlevelmonitor/features/view/provider/filterprovider.dart';
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
        body: SafeArea(
            child: prov.response != 1 &&prov.allfixwaterlevellist.isEmpty
                ? const FadeAnimation(child: ErrorScreen())
                : SizedBox(
                    child: Row(
                      children: [
                        SizedBox(
                          width: size > 1000 ? 80 : 0,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              NavBarPage(),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: size > screensize
                                      ? Row(
                                          children: [
                                          WaterLevelInfo(),
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
                                        )
                                      :  SingleChildScrollView(
                                        child: Container(
                                          height:selectprov.pageSelect==1?MediaQuery.of(context).size.height:1300,
                                          child: Expanded(
                                            child: Column(
                                                children: [
                                                 selectprov.pageSelect==1?SizedBox(): Expanded(child: WaterLevelInfo()),
                                                  const SizedBox(
                                                    height: 20,
                                                  ),
                                                   Expanded(
                                                      child: SizedBox(
                                                    // width: double.infinity,
                                                    // height: double.infinity,
                                                    child: selectprov.pageSelect == 0
                                                        ? FadeAnimation(
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
                                        ),
                                      ),
                                ),
                              ),
                              // SizedBox(
                              //   height: 30,
                              // )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size > 1000 ? 80 : 0,
                        ),
                      ],
                    ),
                  )),
      );
    });
  }
}
