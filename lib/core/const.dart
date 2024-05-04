import 'package:flutter/material.dart';

String appname = "Jal Jeevan";
String servererror = "Issue with server connection";
String interneterror = "No Internet connection";
String changestatusapi = 'http://10.10.1.139:88/api/channel-data/change-active?id=216821&isactive=';
String updateapi = "http://10.10.1.139:88/api/channel-data/update?api_key=A515BB3D88984436";
String latestapi = "http://10.10.1.139:88/api/channel-data/216821/latest-feeds?api_key=CFB2FF3DA4064968";
String feedapi = "http://10.10.1.139:88/api/channel-data/216821/feeds?api_key=CFB2FF3DA4064968&dtfrom=2024-04-01&dtupto=${dateFormatforApi(DateTime.now())}";

String channelid = "216821";

String tempunit = "°C";
String flowunit = "m/s";
String levelunit = "L";

String chlorine = "mg/L";
String turbidity = "NTU";
String ph = "ph";
List<Color> datacolors = [secondarycolor,secondarycolor.withOpacity(0.6),secondarycolor.withOpacity(0.3)];
List<Color> datacolorsacid = [
  const Color.fromARGB(255, 219, 111, 103),
  Color.fromARGB(255, 185, 65, 131),
  Color.fromARGB(255, 233, 184, 51)
  
  ];
List<String>  months = ['Jan','Feb','Mar','Apl','May','June','July','Aug','Sep','Oct','Nov','Dec'];
List<String> dataseriesindicator = ['Level','Flow','Temp'];
List<String> measurementindicator = [levelunit,flowunit,tempunit];
Color primarycolor = const Color.fromARGB(255,17,36,74);
Color backgroundcolor = const Color.fromARGB(255,6,24,49);
Color primarydark = const Color.fromARGB(255, 21, 21, 24);
Color secondarycolor = const  Color.fromARGB(255, 32, 114, 238);

double screensize = 550;

double thresholdlevel = 300;


double todouble(String value){
  double d = 0.0;
  d = double.tryParse(value)??0.0;

  return d;
}

String getTimer(double val){

  double hour = val/(60*60);
  double mins = (val%(60*60))/60;
  double secs = val%(60*60*60);
  

  return '{$hour:$mins:$secs}';

}

String getDate(DateTime date){
  return '${date.day}/${date.month}/${date.year}';
}
String gethour(DateTime date){
  return '${date.hour}:${date.minute}:${date.second}';
}

String dateFormatforApi(DateTime dat){
  String datefor = 'f';
  DateTime date = dat.add(const Duration(days: 2));
  datefor = '${date.year}';

  if(date.month<10){
    datefor = '$datefor-0${date.month}';
  }else{
   datefor = '$datefor-${date.month}';
  }
  if(date.day<10){
    datefor = '$datefor-0${date.day}';
  }else{

   datefor = '$datefor-${date.day}';
  
  }
  return datefor;

}