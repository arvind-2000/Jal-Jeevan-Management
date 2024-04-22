import 'dart:convert';
import 'dart:developer';

import 'package:waterlevelmonitor/core/const.dart';

import 'package:waterlevelmonitor/features/data/usecases/waterlevelusecases.dart';

import 'package:http/http.dart' as http;

import '../../domain/entities/waterlevelentity.dart';
import '../../domain/repositories/waterlevelrepositories.dart';

class WaterLevelModelRepositories extends UseCasesModel implements WaterLevelRepositories {
  


  @override
  Future<bool> pump() async{
var data;
http.get(Uri.parse(api)).then((value){

  if (value.statusCode == 200) {
          // print('okay in service');
          data = jsonDecode(value.body) as Map<String, dynamic>;
          print("$data");
     
        } else {
          if (value.statusCode == 500) {
            print('server error');
        
          } else {
            print('client error');

          }
        }

});
      
  return data['isActive'];
 

  }
  
  @override
  Future<List<WaterLevel>> getWaterLevelLatest({required String url}) async {


    List<WaterLevel> datas = [];
    WaterLevel waterdata = WaterLevel(name: '',date: DateTime.now(),elevation: 0,flow: 0.0,level: 0.0,temp: 0.0,totalflow: 0.0);


      await http.get(Uri.parse(url)).then((value) {

        print('in service response');
        if (value.statusCode == 200) {
          // print('okay in service');
          var data = jsonDecode(value.body) as Map<String, dynamic>;
          print("${data['channel']['name']} ${data['feeds'].length}");
          waterdata = convertValues(name:  data['channel']['id'], level: data['feeds']['field1'], flow: data['feeds']['field3'], temp: data['feeds']['field2'], date: data['feeds']['created'], elevation: data['feeds']['elevation'],totalflow:data['feeds']['field5'] );
        } else {
          if (value.statusCode == 500) {
            print('server error');
          } else {
            print('client error');
  
          }
        }
      
          datas.add(waterdata);
        
      });
    


    return  datas;
  }
  
  @override
  Future<List<WaterLevel>> getWaterLevel({required String url}) async {
          List<WaterLevel> datas = [];
   


      await http.get(Uri.parse(url)).then((value) {

        print('in service response');
        if (value.statusCode == 200) {
          // print('okay in service');
          log('In service response');
          var data = jsonDecode(value.body) as Map<String, dynamic>;

            print("${data['channel']['name']} ${data['feeds'].length}  ${data['feeds'][0]['field1']}");
          for(int i = 0;i<data['feeds'].length;i++){
            WaterLevel waterdata = WaterLevel(name: '',date: DateTime.now(),elevation: 0,flow: 0.0,level: 0.0,temp: 0.0,totalflow: 0.0);
            waterdata = convertValues(name:  data['channel']['id'], level: data['feeds']['field1'], flow: data['feeds']['field3'], temp: data['feeds']['field2'], date: data['feeds']['created'], elevation: data['feeds']['elevation'],totalflow:data['feeds']['field5'] );    
            datas.add(waterdata);
          
          }


         
      
        } else {
          if (value.statusCode == 500) {
            print('server error');
          } else {
            print('client error');
  
          }
        }
    
        
      });
    


    return  datas;
  }



}