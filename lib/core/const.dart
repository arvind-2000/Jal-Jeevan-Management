import 'package:flutter/material.dart';

String appname = "Jal Jeevan";
String servererror = "Issue with server connection";
String interneterror = "No Internet connection";
String updateapi = "http://10.10.1.139:88/api/channel-data/update?api_key=A515BB3D88984436";
String latestapi = "http://10.10.1.139:88/api/channel-data/216821/latest-feeds?api_key=CFB2FF3DA4064968";
String feedapi = "http://10.10.1.139:88/api/channel-data/216821/feeds?api_key=CFB2FF3DA4064968&dtfrom=2024-04-01&dtupto=${dateFormatforApi(DateTime.now())}&interval=20";

String channelid = "216821";

String tempunit = "°C";
String flowunit = "m/s";
String levelunit = "L";

List<String>  months = ['Jan','Feb','Mar','Apl','May','June','July','Aug','Sep','Oct','Nov','Dec'];

Color primarycolor = const Color.fromARGB(255,17,36,74);
Color backgroundcolor = const Color.fromARGB(255,6,24,49);
Color primarydark = const Color.fromARGB(255, 21, 21, 24);
Color secondarycolor = const  Color.fromARGB(255, 32, 114, 238);


double todouble(String value){
  double d = 0.0;
  d = double.tryParse(value)??0.0;

  return d;
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