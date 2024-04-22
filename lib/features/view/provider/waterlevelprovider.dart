import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/features/data/repositories/watermodelrepositories.dart';
import 'package:waterlevelmonitor/features/domain/entities/waterlevelentity.dart';

class WaterLevelProvider extends WaterLevelModelRepositories with ChangeNotifier {

  List<WaterLevel> _waterlevellist = [];
  List<WaterLevel> _allwaterlevellist = [];
  List<WaterLevel> get waterlevellist => _waterlevellist;
  List<WaterLevel> get allwaterlevellist => _allwaterlevellist;

  var _scheduler;

  bool isLoading = false;
  int isgraph = 0;
  int recordtime = 0;
  bool isOnoff = false;
  DateTime currentdate = DateTime.now();
  



  void getDatas() async {


    
   _allwaterlevellist = await  getWaterLevel(url:feedapi);
  _waterlevellist = await getWaterLevelLatest(url: latestapi);
    notifyListeners();
  
    changeData();

    scheduletimer();
  }



void scheduletimer() async{
  // isOnoff = await pump();
  notifyListeners();

  _scheduler = Timer.periodic(const Duration(seconds: 10), (timer)  async{ 
  _waterlevellist = await getWaterLevelLatest(url: api);
http.get(Uri.parse(api)).then((value){

  if (value.statusCode == 200) {
          // print('okay in service');
          var data = jsonDecode(value.body) as Map<String, dynamic>;
          print("$data");
          isOnoff =  data['isActive'];
        } else {
          if (value.statusCode == 500) {
            print('server error');
        
          } else {
            print('client error');

          }
        }
  notifyListeners();
});

  // isOnoff = await pump();

    notifyListeners();
  });
}


  void changeGraph(int value){
    isgraph = value;
    notifyListeners();
  }
 void changeRecord(int value){
    recordtime = value;
    notifyListeners();
    changeData();
  }

  void switches(bool value){
    isOnoff = value;
        pumpSwitch(value);
 
      pump().then((v){
        isOnoff = v;
        notifyListeners();
      });

    notifyListeners();
  }


 
 
 
 
  void changeData(){

    if(recordtime == 0 ){
        //monthly 
  _waterlevellist =  monthly(_allwaterlevellist, currentdate);  
    }else if(recordtime == 1){

        //yearly

_waterlevellist =  yearly(_allwaterlevellist, currentdate);  
    }else{

    

    }

  notifyListeners();
  }

  

  
}