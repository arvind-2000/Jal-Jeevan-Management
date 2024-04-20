
import 'package:flutter/material.dart';
import 'package:waterlevelmonitor/core/const.dart';

final darktheme = ThemeData(
    appBarTheme: const AppBarTheme(
   
    backgroundColor: Colors.black,
    elevation: 0
  ),
  fontFamily: 'Montserrat',
  colorScheme: ColorScheme.dark(brightness:Brightness.dark, primary:primarydark, onPrimary: Colors.grey[800]!, secondary:secondarycolor, onSecondary: Colors.blue[100]!, error: Colors.redAccent,
   onError: Colors.redAccent.withOpacity(0.3), background: Colors.black, 
   onBackground:Colors.black, 
   surface: Colors.white, onSurface: Colors.white)

); 

