import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterlevelmonitor/core/themes/darkthemes.dart';
import 'package:waterlevelmonitor/features/view/provider/filterprovider.dart';
import 'package:waterlevelmonitor/features/view/provider/pageselectprovider.dart';
import 'package:waterlevelmonitor/homescreen.dart';
import 'package:waterlevelmonitor/features/view/provider/waterlevelprovider.dart';

import 'core/const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return 
    MultiProvider(providers: [

        ChangeNotifierProvider(create: (c)=>WaterLevelProvider()),
        ChangeNotifierProvider(create: (c)=> PageSelectProvider()),
        ChangeNotifierProvider(create: (c)=> Filterprovider()),

    ],
    child: MaterialApp(
      title: appname,
      debugShowCheckedModeBanner: false,
      theme: darktheme,
      home: const HomeScreen(),
    ));
  }
}
