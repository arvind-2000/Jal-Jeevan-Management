import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/features/data/repositories/watermodelrepositories.dart';
import 'package:waterlevelmonitor/features/domain/entities/waterlevelentity.dart';

class WaterLevelProvider extends WaterLevelModelRepositories with ChangeNotifier {

  List<WaterLevel> _waterlevellist = [];
  List<WaterLevel> _allwaterlevellist = [];
  List<WaterLevel> _allfix = [];
  List<WaterLevel> get waterlevellist => _waterlevellist;
  List<WaterLevel> get allwaterlevellist => _allwaterlevellist;

  dynamic _scheduler;

  bool isLoading = false;
  int isgraph = 0;
  int recordtime = 0;
  bool isOnoff = false;
  DateTime currentdate = DateTime.now();
  int response = 0;



  void getDatass() async {
    isLoading = true;
    getLatestdata();
    getAlldata();
    changeData();
    //scheduletimer();
    checkConnection();
  notifyListeners();
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



// void scheduletimer() async{
//   // isOnoff = await pump();
//   notifyListeners();

//   _scheduler = Timer.periodic(const Duration(seconds: 10), (timer)  async{ 
//     getLatestdata();
//     checkConnection();
// http.get(Uri.parse(api)).then((value){

//   if (value.statusCode == 200) {
//           // print('okay in service');
//           var data = jsonDecode(value.body) as Map<String, dynamic>;
//           print("$data");
//           isOnoff =  data['isActive'];
//         } else {
//           if (value.statusCode == 500) {
//             print('server error');
        
//           } else {
//             print('client error');

//           }
//         }
//   notifyListeners();
// });

//   // isOnoff = await pump();

//     notifyListeners();
//   });
// }


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

  

  
}