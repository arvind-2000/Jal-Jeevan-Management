import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/features/data/repositories/watermodelrepositories.dart';
import 'package:waterlevelmonitor/features/domain/entities/waterlevelentity.dart';

class WaterLevelProvider extends WaterLevelModelRepositories with ChangeNotifier {

  List<WaterLevel> _waterlevellist = [];
  List<WaterLevel> _allwaterlevellist = [];
  List<WaterLevel> _allfix = [];
  List<WaterLevel> get allwaterlevellist => _allwaterlevellist;
  List<WaterLevel> get waterlevellist => _waterlevellist;
  List<WaterLevel> get allfixwaterlevellist => _allfix;

  dynamic _scheduler;

  bool isLoading = false;
  int isgraph = 0;
  int recordtime = 1;
  bool isOnoff = false;
  DateTime currentdate = DateTime.now();
  int response = 0;

  int selecTimeSchedule = 0;
  int timeschedule = 5*60;

  void getDatass() async {
    isLoading = true;
    getLatestdata();
    getAlldata();
    changeData();

    checkConnection();
    notifyListeners();

    schedulePumptimer();
    scheduleAlltimer();
  }





  void getLatestdata() async{


 await getWaterLevelLatest(url: latestapi).then((value){

  _waterlevellist = value.entries.first.key;
  log('in latest');
   log('$response  $isLoading');
  switcheschange();
 });


  }


void getAlldata() async{

  await  getWaterLevel(url:feedapi).then((value){

    _allfix = value.entries.first.key;

    response = value.entries.first.value;

    checkConnection();
    changeData();
    notifyListeners();
log('in all');
    log('$response  $isLoading');
  });

}


void changeTimeSchedule(int value,int option){
  timeschedule = value*60;
  selecTimeSchedule = option;
  notifyListeners();
}


void checkConnection(){
    isLoading = false;
    
    if(response != 1){
      cancelTimer();
    }

}


void cancelTimer(){
  if(_scheduler!=null){
     _scheduler.cancel();
  }

}



void schedulePumptimer() async{
  // isOnoff = await pump();
  notifyListeners();

  _scheduler = Timer.periodic(const Duration(seconds: 5), (timer)  async{ 
    getLatestdata();
    checkConnection();
 if(_waterlevellist.last.elevation==1){
      checkthreshold();
    }
  // isOnoff = await pump();

    notifyListeners();
   

  });
}



void scheduleAlltimer() async{

  notifyListeners();

  _scheduler = Timer.periodic(const Duration(minutes: 10), (timer)  async{ 
    getAlldata();
    checkConnection();

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

  void switcheschange(){
    if(_waterlevellist.last.elevation==0){
      isOnoff = false;
    }else{
      isOnoff = true;
    }
    notifyListeners();

  }

  void switches(bool value){

    pumpSwitch(value,_waterlevellist.last);

    notifyListeners();
    getLatestdata();
    getAlldata();
    

  }


 void checkthreshold(){
    if(_waterlevellist.last.level>=thresholdlevel){
      switches(false);
    }

 }
 
 
 
  void changeData(){
      log('in changedate of data');
    if(recordtime == 0 ){
        //monthly 
  _allwaterlevellist =  weekly(_allfix, currentdate); 

  log('0 ${_allwaterlevellist.length}');

    }else if(recordtime == 1){

        //yearly
  _allwaterlevellist =  monthly(_allfix, currentdate); 

  log('1 ${_allwaterlevellist.length}');

    }else{

    

_allwaterlevellist =  yearly(_allfix, currentdate);  

    }
notifyListeners();

  }


void starttimer(){




}
  

  
}