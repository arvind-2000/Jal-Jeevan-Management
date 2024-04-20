import 'package:flutter/material.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/features/data/repositories/watermodelrepositories.dart';
import 'package:waterlevelmonitor/features/domain/entities/waterlevelentity.dart';

class WaterLevelProvider extends WaterLevelModelRepositories with ChangeNotifier {

  List<WaterLevel> _waterlevellist = [];
  List<WaterLevel> get waterlevellist => _waterlevellist;
  
  bool isLoading = false;
  int isgraph = 0;
  int recordtime = 0;
  bool isOnoff = false;

  void getData(){
   _waterlevellist = getWaterLevel(url:api);
    notifyListeners();
  }


  void changeGraph(int value){
    isgraph = value;
    notifyListeners();
  }
 void changeRecord(int value){
    recordtime = value;
    notifyListeners();
  }

  void switches(){

      isOnoff = !isOnoff;

    notifyListeners();
  }




  
}