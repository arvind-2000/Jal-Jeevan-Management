import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:waterlevelmonitor/features/domain/entities/waterlevelentity.dart';

import '../../../core/const.dart';

class UseCasesModel {
  void getData(String url) {}

  WaterLevel convertValues(
      {required String name,
      required String level,
      required String flow,
      required String temp,
      required String elevation,
      required String date,
      required String totalflow,
      
      
      }
      ) {
    WaterLevel d = WaterLevel(
        name: '',
        level: 0.0,
        flow: 0.0,
        temp: 0.0,
        date: DateTime.now(),
        elevation: 0,
        totalflow: 0.0);

  log(' In convert values $name $level  $flow  $date' );
    try {
      d.name = name;
      d.level = double.tryParse(level)??0;
      d.flow = double.tryParse(flow)??0;
      d.temp = double.tryParse(temp)??0;
      d.elevation = int.tryParse(elevation)??0;
      d.date = DateTime.tryParse(date)??DateTime.now();
      d.totalflow = double.tryParse(totalflow)??0;
    } catch (e) {
      log('error converting data');
    }

    return d;
  }



List<WaterLevel> monthly(List<WaterLevel> data,DateTime dates){
  List<WaterLevel>  da = data;
  List<WaterLevel> temp = [];
  int tempdate = 0;
  da.sort((a,b)=>b.date.compareTo(a.date));

    temp.add(data.first);
    tempdate = da.first.date.month;
  for(WaterLevel d in da){

      if(d.date.year==dates.year){

          if(d.date.month == tempdate){

                temp.add(d);

          }

      }


  }
  
  return temp;
  
}

 List<WaterLevel> yearly(List<WaterLevel> data,DateTime dates){
  List<WaterLevel>  da = data;
  List<WaterLevel> temp = [];
  int tempdate = 0;
  da.sort((a,b)=>b.date.compareTo(a.date));

    temp.add(data.first);
    tempdate = da.first.date.month;
  for(WaterLevel d in da){

      if(d.date.year==dates.year){

          if(d.date.month != tempdate){

              tempdate = d.date.month;
                temp.add(d);

          }

      }


  }
  

  return temp;
 
 }


  Future<int> pumpSwitch(bool value) async{
    int res = 0;
    try{
        Uri url = Uri.parse('$updateapi?id=$channelid&isactive=$value');
        log(url.toString());
        final response = await http.post(url);
        
        
        res = response.statusCode;
    
        log('change pump switch: $res');
    }catch(e){

    }

    return res;
  }


}
