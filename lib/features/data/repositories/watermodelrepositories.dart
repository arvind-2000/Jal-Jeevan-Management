import 'dart:convert';
import 'dart:developer';
import 'package:waterlevelmonitor/features/data/usecases/waterlevelusecases.dart';

import 'package:http/http.dart' as http;

import '../../domain/entities/waterlevelentity.dart';
import '../../domain/repositories/waterlevelrepositories.dart';

class WaterLevelModelRepositories extends UseCasesModel implements WaterLevelRepositories {
  
int response = 0;

  
  @override
  Future<Map<List<WaterLevel>,int>> getWaterLevelLatest({required String url}) async {


    List<WaterLevel> datas = [];
    WaterLevel waterdata = WaterLevel(name: '',date: DateTime.now(),elevation: 0,flow: 0.0,level: 0.0,temp: 0.0,totalflow: 0.0);
    
    int res = 1;

    try {
  final response = await http.get(Uri.parse(url));
        
      print('in service response latest');
  
      if (response.statusCode == 200) {
          res = 1;
        // print('okay in service');
        var data = jsonDecode(response.body) as Map<String, dynamic>;
        print("=> ${data['channel']['name']} ${data['feeds'].length}");
    for(int i = 0;i<data['feeds'].length;i++){
  
          WaterLevel waterdata = WaterLevel(name: '',date: DateTime.now(),elevation: 0,flow: 0.0,level: 0.0,temp: 0.0,totalflow: 0.0);
         
        String name = data['feeds'][i]['channelId'];
        String level = data['feeds'][i]['field1'];
        String flow = data['feeds'][i]['field4'];
        String temp = data['feeds'][i]['field2'];
        String totalflow=data['feeds'][i]['field5'];
        String elevation = data['feeds'][i]['elevation'];
        String date = data['feeds'][i]['created'];
  
  
        waterdata = convertValues(name:  name, level: level, flow: flow, temp: temp, date: date, elevation:elevation,totalflow:totalflow );
         
          datas.add(waterdata);
      
        }

           return  {datas:res};
      } else {
        if (response.statusCode == 500) {
          res = 4;
          print('server error');
           return  {datas:res};
        } else {
          res = 2;
           print('client error');
          return  {datas:res};
        }
      }
} on Exception catch (e) {
    log('error in latest fetch');
    res = 4;
     return  {datas:res};
}
      
 
        
  
    



  }
  
  @override
  Future<Map<List<WaterLevel>,int>> getWaterLevel({required String url}) async {
          List<WaterLevel> datas = [];
        int res;


      try {
  final response = await http.get(Uri.parse(url));
      
    // print('in service response');
    if (response.statusCode == 200) {
      res = 1;
      // print('okay in service');
      // log('In service response');
      var data = jsonDecode(response.body) as Map<String, dynamic>;
        // log('in data field waterlevel ${data['feeds'].length}');
  
  
      //   print("${data['channel']['name']} ${data['feeds'].length}  ${data['feeds'][0]['field1']}");
      for(int i = 0;i<data['feeds'].length;i++){
  
        WaterLevel waterdata = WaterLevel(name: '',date: DateTime.now(),elevation: 0,flow: 0.0,level: 0.0,temp: 0.0,totalflow: 0.0);
       
      String name = data['feeds'][i]['channelId'];
      String level = data['feeds'][i]['field1'];
      String flow = data['feeds'][i]['field4'];
      String temp = data['feeds'][i]['field2'];
      String totalflow=data['feeds'][i]['field5'];
      String elevation = data['feeds'][i]['elevation'];
      String date = data['feeds'][i]['created'];
  
  
      waterdata = convertValues(name:  name, level: level, flow: flow, temp: temp, date: date, elevation:elevation,totalflow:totalflow );
       
        datas.add(waterdata);
      
      }
      return  {datas:res};
  
    } else {
      if (response.statusCode == 500) {
           res = 4;
        print('server error');
         return  {datas:res};
      } else {
           res = 2;
        print('client error');
         return  {datas:res};
    
      }
    }
} on Exception catch (e) {
    log("in client error");
    res = 4;
     return  {datas:res};
}


  }
  
  @override
  Future<Map<bool, int>> getStatus({required String url})  async{
     bool d = false;
     int res = 0;


 try {
  final response = await http.get(Uri.parse(url));
      
    // print('in service response');
    if (response.statusCode == 200) {

      // print('okay in service');
      // log('In service response active');
      var data = jsonDecode(response.body) as Map<String, dynamic>;
        // log('in data field ${data['feeds'].length}');
        if(data.isNotEmpty){
      d =data['channel']['isActive'];
      //  log('in active $d');
        }
  return {d:res};
        }
} on Exception catch (e) {
    log("in client error");
    res = 4;
      return {d:res};
}
 
  return {d:res};
 
  }
  
  @override
  Future <int> getAutoPumpStatus({required String url})  async{
       int d = 2;
     int res = 0;


 try {

  final response = await http.get(Uri.parse(url));
      
    // print('in service response');
    if (response.statusCode == 200) {

      // print('okay in service');
      // log('In service response');
      var data = jsonDecode(response.body) as Map<String, dynamic>;
        // log('in data field autopumpstatus ${data['feeds'].length}');
        if(data.isNotEmpty){
      String x = data['feeds'][0]['field7'];    
          d = int.tryParse(x)??2;
        }
      return d;
        }
} on Exception catch (e) {
    log("in client error");
    res = 4;
      return d;

}
 
  return d;

  }
  
  @override
  Future<int> getField8({required String url})  async{
   int d = 2;
     int res = 0;


 try {

  final response = await http.get(Uri.parse(url));
      
    // print('in service response');
    if (response.statusCode == 200) {

      // print('okay in service');
      // log('In service response');
      var data = jsonDecode(response.body) as Map<String, dynamic>;
        // log('in data field autopumpstatus ${data['feeds'].length}');
        if(data.isNotEmpty){
      String x = data['feeds'][0]['field8'];    
          d = int.tryParse(x)??2;
        }
      return d;
        }
} on Exception catch (e) {
    log("in client error");
    res = 4;
      return d;
}
 
  return d;
  }


}