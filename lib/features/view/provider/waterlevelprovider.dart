import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/core/dummy.dart';
import 'package:waterlevelmonitor/features/data/repositories/watermodelrepositories.dart';
import 'package:waterlevelmonitor/features/domain/entities/waterlevelentity.dart';

class WaterLevelProvider extends WaterLevelModelRepositories with ChangeNotifier {

  List<WaterLevel> _waterlevellist = [];
  List<WaterLevel> _allwaterlevellist = [];
  List<WaterLevel> _allfix = [];
  List<WaterLevel> get allwaterlevellist => _allwaterlevellist;
  List<WaterLevel> get waterlevellist => _waterlevellist;
  List<WaterLevel> get allfixwaterlevellist => _allfix;
  bool checkdata = false;
  dynamic _scheduler;

  bool isLoading = false;
  int isgraph = 0;
  int recordtime = 1;
  bool isOnoff = false;
  DateTime currentdate = DateTime.now();
  int response = 0;
  bool isActive = false;
  int selecTimeSchedule = 0;
  int timeschedule = 5*60;
  bool isAutomatic = false;
  void getDatass() async {
    isLoading = true;
    getLatestdata();
    getAlldata();
    changeData();


    notifyListeners();
    checkConnection();
    schedulePumptimer();
    scheduleAlltimer();

  }


void chechData(){
  if(!checkdata){

  if(waterlevellist.isNotEmpty && allfixwaterlevellist.isNotEmpty && response == 1){
    checkdata = true;

    notifyListeners();
  }else{
    
    checkdata = false;    
  notifyListeners();

  }
  }


}




  void getLatestdata() async{
    Map<List<WaterLevel>,int> value = {};
    int pumpstat = 0;
  value = await getWaterLevelLatest(url: latestapi);

  if(value.entries.first.value==1){
    if(value.entries.first.key.isNotEmpty){
  _waterlevellist = value.entries.first.key;
    }
  }

//   log('in latest');
  
//   log('in latest ${_waterlevellist.length}');
//    log('$response  $isLoading');
//  log('in latest data  $checkdata');


  pumpstat =  await getAutoPumpStatus(url: latestapi);
  
    if(pumpstat==0 || pumpstat==1){
        isAutomatic = false;
        if(!isAutomatic){
            isOnoff = pumpstat==1?true:false;
            notifyListeners();
        }
    }else{
      isAutomatic = true;
    }
    notifyListeners();



await getStatus(url: latestapi).then((value){
  isActive = value.entries.last.key;
  notifyListeners();

});

  switcheschange();

  }




void getAlldata() async{

//   await  getWaterLevel(url:feedapi).then((value){

//     _allfix = value.entries.first.key;

//     response = value.entries.first.value;

//     checkConnection();
//     changeData();
//     notifyListeners();
// log('in all');
//     log('$response  $isLoading');
//   });
    _allfix = waterleveldummy;
    response = 1;
    checkConnection();
    changeData();
    chechData();
    notifyListeners();

}


void changeTimeSchedule(int value,int option){
  timeschedule = value*60;
  selecTimeSchedule = option;
  notifyListeners();
}


void checkConnection(){
    if(response>0){
      isLoading = false;
    }
    notifyListeners();
    chechData();
    // if(response != 1){
    //   log('response $response');
    //   cancelTimer();
     
    // }



}


// void cancelTimer(){
//   if(_scheduler!=null){
//      _scheduler.cancel();
//   }

// }



void schedulePumptimer() async{
  // isOnoff = await pump();
  notifyListeners();

  _scheduler = Timer.periodic(const Duration(seconds: 1), (timer)  async{ 
    getLatestdata();
    checkConnection();

    notifyListeners();
   

  });
}



void scheduleAlltimer() async{
    getAlldata();
  notifyListeners();

  _scheduler = Timer.periodic(const Duration(minutes: 1), (timer)  async{ 
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
    if(isAutomatic){

    if(_waterlevellist.last.elevation==0){
    
        pumpSwitch(false, _waterlevellist.last);
      
      isOnoff = false;
    }else{

      if(!isActive){
        pumpSwitch(true,_waterlevellist.last);
  
      }

            isOnoff = true;
    }

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