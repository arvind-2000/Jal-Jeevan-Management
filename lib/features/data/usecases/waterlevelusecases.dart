import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:waterlevelmonitor/features/domain/entities/wateracidityentity.dart';

import 'package:waterlevelmonitor/features/domain/entities/waterlevelentity.dart';

import '../../../core/const.dart';

class UseCasesModel {
  void getData(String url) {
    
  }

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

  // log(' In convert values $name $level  $flow  $date' );
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

  List<WaterLevel> temp = [];

  int tempdate = 0;
  if (data.isNotEmpty) {
      List<WaterLevel>  da = data;
  da.sort((a,b)=>b.date.compareTo(a.date));
  
    // temp.add(data.first);
    // tempdate = da.first.date.month;
  for(WaterLevel d in da){
  
      if(d.date.year==dates.year){
  
          if(d.date.month == dates.month){

            if(d.date.day!=tempdate){
              tempdate = d.date.day;
              temp.add(d);
            }
       
             
          }
  
      }
  
  
  }
  temp.sort((a,b)=>a.date.compareTo(b.date));

}
  return temp;
  
}


List<WaterAcidityEntity> monthlyacidity(List<WaterAcidityEntity> data,DateTime dates){

  List<WaterAcidityEntity> temp = [];

  int tempdate = 0;
  if (data.isNotEmpty) {
      List<WaterAcidityEntity>  da = data;
  da.sort((a,b)=>b.dateTime.compareTo(a.dateTime));
  
    // temp.add(data.first);
    // tempdate = da.first.date.month;
  for(WaterAcidityEntity d in da){
  
      if(d.dateTime.year==dates.year){
  
          if(d.dateTime.month == dates.month){

            if(d.dateTime.day!=tempdate){
              tempdate = d.dateTime.day;
              temp.add(d);
            }
       
             
          }
  
      }
  
  
  }
  temp.sort((a,b)=>a.dateTime.compareTo(b.dateTime));

}
  return temp;
  
}
List<WaterLevel> weekly(List<WaterLevel> data,DateTime dates){

  List<WaterLevel> temp = [];

  int tempdate = 0;
  if (data.isNotEmpty) {

  List<WaterLevel>  da = data;
  da.sort((a,b)=>b.date.compareTo(a.date));
  
    // temp.add(data.first);
    // tempdate = da.first.date.month;
  for(WaterLevel d in da){
  
      if(d.date.year==dates.year){
  
          if(d.date.month == dates.month){
            if(d.date.day == dates.day){
                
                if(d.date.minute!=tempdate){
                tempdate = d.date.minute;
                temp.add(d);
                }
          
  
            }
            
  
          }
  
      }
  
  
  }
  temp.sort((a,b)=>a.date.compareTo(b.date));
}
  return temp;
  
}

List<double> avg(List<WaterLevel> wat){
  double dlev = 0.0;
  double dflow = 0.0;
  double dtemp = 0.0;

  for(WaterLevel i in wat){
    dlev = dlev + i.level;
    dflow = dflow + i.totalflow;
    dtemp = dtemp + i.temp;
  }




  return [(dlev/wat.length),(dflow/wat.length),(dtemp/wat.length)];

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
  
 temp.sort((a,b)=>a.date.compareTo(b.date));
  return temp;
 
 }


  Future<int> pumpSwitch(bool value,WaterLevel waterLevel) async{
    int res = 0;

    
    try{
        // Uri url = Uri.parse('$updateapi&field1=${waterLevel.level}&field2=${waterLevel.temp}&field4=${waterLevel.flow}&field5=${waterLevel.totalflow}&elevation=${value?1:0}');
        Uri url  = Uri.parse('$changestatusapi$value'); 
        log(url.toString());
        final response = await http.post(url);
        res = response.statusCode;
    
        log('change pump switch: $res');
    }catch(e){

    }

    return res;
  }

  Future<int> changepumpSwitch(int value,WaterLevel waterLevel,int field8,int elev) async{
    int res = 0;

    
    try{
        Uri url = Uri.parse('$updateapi&field1=${waterLevel.level}&field2=${waterLevel.temp}&field4=${waterLevel.flow}&field5=${waterLevel.totalflow}&elevation=$elev&field7=$value&field8=$field8');
  
        log(url.toString());
        final response = await http.post(url);
        res = response.statusCode;
    
        log('change pump switch: $res');
    }catch(e){

    }

    return res;
  }

    Future<int> changeField8Switch(int value,WaterLevel waterLevel,int field7) async{
    int res = 0;

    
    try{
        Uri url = Uri.parse('$updateapi&field1=${waterLevel.level}&field2=${waterLevel.temp}&field4=${waterLevel.flow}&field5=${waterLevel.totalflow}&elevation=${waterLevel.elevation}&field7=$field7&field8=$value');
  
        log(url.toString());
        final response = await http.post(url);
        res = response.statusCode;
    
        log('change pump switch: $res');
    }catch(e){

    }

    return res;
  }

}
