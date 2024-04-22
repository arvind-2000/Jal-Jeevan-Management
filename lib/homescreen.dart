import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<WaterLevelProvider>(context, listen: false).getDatas();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const SafeArea(
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
                    child: Row(
                      children: [
                        WaterLevelInfo(),
                        Expanded(
                            child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: Column(
                            children: [
                              Expanded(flex: 4, child: GraphScreen()),
                              Expanded(flex: 2, child: ReportScreen())
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 80,
            ),
          ],
        ),
      )),
    );
  }
}


