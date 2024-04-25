import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterlevelmonitor/core/animations/fadeamimation.dart';
import 'package:waterlevelmonitor/core/error/errorscreen.dart';

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
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body:  SafeArea(
          child:prov.response!=1?const FadeAnimation(child: ErrorScreen()) :const FadeAnimation(
            child: SizedBox(
                    child: Row(
            children: [
              SizedBox(
                width: 80,
              ),
              Expanded(
                child: Column(
                  children: [
                    NavBarPage(),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          children: [
                            WaterLevelInfo(),
                            SizedBox(width: 20,),
                            Expanded(
                                child: SizedBox(
                              width: double.infinity,
                              height: double.infinity,
                              child: Column(
                                children: [
                                  Expanded(flex: 4, child: GraphScreen()),
                                  SizedBox(height: 20,),
                                  Expanded(flex: 2, child: ReportScreen())
                                ],
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30,)
                  ],
                ),
              ),
              SizedBox(
                width: 80,
              ),
            ],
                    ),
                  ),
          )),
    );
  }
}


