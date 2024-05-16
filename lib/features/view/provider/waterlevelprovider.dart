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
  bool isconnected = false;
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
  int seconds = 1;
  bool isDataApi = false;
  bool nopower = false;
  bool isField8 = false;
  DateTime temp = DateTime.now();
  int tempdur = 0;
  int tempo = 0;
  bool autoOffSwitch = true;
  void getDatass(){
    response = 0;  
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

  isLoading = false;
  notifyListeners();
  }


}

void autoOffPump(bool val){
  autoOffSwitch = val;
  tempdur = 0;
  notifyListeners();
}

  void getLatestdata() async{
    Map<List<WaterLevel>,int> value = {};
    int pumpstat = 0;
    int field8state = 0;

  value = await getWaterLevelLatest(url: latestapi); 
  
  //  value = {[]:1};
  response = value.entries.first.value;
  log('in latest response $response');
  if(response == 1){
    isconnected = true;
    if(value.entries.first.key.isNotEmpty){
  _waterlevellist = value.entries.first.key;

    if (autoOffSwitch) {
  if(isActive){
  
   
      if(temp == _waterlevellist.first.date){
            tempdur++;
        print('in active  $tempdur');
        if(tempdur>30){ 
          nopower = true;
          tempdur = 0;
      if(temp == _waterlevellist.first.date){
        if(nopower){
         log(' in active no power no connection  $tempdur');
        changepumpSwitch(isAutomatic?2:0, _waterlevellist.last, 0,0);
        pumpSwitch(false, _waterlevellist.last);
       nopower = false;
      
  
        }
      }else{
        nopower = false;
        tempdur = 0;
        temp = _waterlevellist.first.date;
      }
  
     
    
     
  
        }
  
      }else{
          temp = _waterlevellist.first.date;
          
          tempdur = 0;
          nopower = false;
            print('in not date active ');
            
      }
  
  
  }
}

  
    }
    else{

      _waterlevellist = [waterleveldummy.last];
    }

  }else{
    isconnected = false;
  }

  checkConnection();
  
  log('in latest');
  
  log('in latest ${_waterlevellist.length}');
   log('$response  $isLoading');
 log('in latest data  $checkdata');


  await getAutoPumpStatus(url: latestapi).then((value) {
    pumpstat = value;
    if(pumpstat==0 || pumpstat==1){
        isAutomatic = false;

        if(!isAutomatic){

            isOnoff = pumpstat==1?true:false;
    
        }
    }else{
      isAutomatic = true;
    }


    notifyListeners();

  });

  await getField8(url: latestapi).then((value) {
    field8state = value;
    if(field8state==1){
        isField8 = true;
    }else{
      isField8 = false;
    }


    notifyListeners();

  });


await getStatus(url: latestapi).then((value){
  isActive = value.entries.last.key;
  notifyListeners();

});

  switcheschange();

  }




void getAlldata() async{
    log('in get all data');
  if(isDataApi){
  await  getWaterLevel(url:feedapi).then((value){

        response = value.entries.first.value;
      if(value.entries.first.key.isNotEmpty){
      _allfix = value.entries.first.key;
      }else{


    _allfix = waterleveldummy;

  }
  

  

    checkConnection();
    changeData();
    notifyListeners();
log('in all');
    log('$response  $isLoading');
  });

  }else{


    _allfix = waterleveldummy;

  }

    // response = 1;
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


void automicSwitch(int val){
  changepumpSwitch(val,_waterlevellist.last,isField8?1:0,_waterlevellist.last.elevation);
  getLatestdata();
}

void checkConnection(){
  
    // if(response>0){
    //   isLoading = false;
    // }
    // notifyListeners();
    chechData();
    // if(response != 1){
    //   log('response $response');
    //   cancelTimer();
     
    // }



}

//for chagging between api and dummy data
void changeDataApi(bool val){

  isDataApi = val;
  notifyListeners();
  getAlldata();


}

void cancelTimer(){
  if(_scheduler!=null){
     _scheduler.cancel();
  }

}



void schedulePumptimer(){
  // isOnoff = await pump();
  _scheduler = Timer.periodic(Duration(seconds: seconds), (timer)  async{ 
    if(response == 1){
    log('\n\nin pump scheduler ${seconds}\n');
    getLatestdata();
    checkConnection();

    notifyListeners();
    }



  });
}



void scheduleAlltimer() async{
    getAlldata();
  notifyListeners();

  _scheduler = Timer.periodic(const Duration(minutes: 1), (timer)  async{ 
    if(response == 1){
    getAlldata();
    
    checkConnection();

    notifyListeners();
    }


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
    if(isconnected){

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
    //for getting data after each switch change might not needed in future
    // getLatestdata();

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


void changeField8(bool val){
  
  changeField8Switch(val?1:0, waterlevellist.last, isAutomatic?2:isOnoff?1:0);
  

}
  
void timerseconds(bool plus){
  if(plus){
      seconds++;
      notifyListeners();
      _scheduler.cancel();

      schedulePumptimer();

  }else{
    if(seconds>1){
      seconds--;
      notifyListeners();
  
               _scheduler.cancel();
      schedulePumptimer();
    }else{
      seconds = 1;
    }
  }
  notifyListeners();

}



  
}