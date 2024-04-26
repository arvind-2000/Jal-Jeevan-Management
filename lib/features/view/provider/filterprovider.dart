import 'package:flutter/material.dart';
import 'package:waterlevelmonitor/features/data/usecases/waterlevelusecases.dart';

import '../../domain/entities/waterlevelentity.dart';

class Filterprovider extends UseCasesModel with ChangeNotifier{

  DateTime currentdate = DateTime.now();
  
  // 0 for years 1 month 2 days
  
  int timerecord = 0;
  int datatype = 0;
  List<WaterLevel> _filterlist = [];
  List<WaterLevel> _filtermonths = [];
  List<WaterLevel> get filterlist => _filterlist;
  List<double> avgslevel = [0,0,0];

  void init(List<WaterLevel> waterlevel){
  
    _filterlist = waterlevel;
    notifyListeners();
  changeList(_filterlist);
  }


  void changeTime(int value,List<WaterLevel> list,DateTime d){

      timerecord = value;
      currentdate = d;
      notifyListeners();
      changeList(list);
      
  }

void changeList(List<WaterLevel> list){

  if(timerecord==0){
     _filterlist = yearly(list,  currentdate);
  }else if(timerecord == 1){

     _filterlist =  monthly(list,  currentdate);
  }else{
  _filterlist = weekly(list,  currentdate);

  }
  avgslevel = avg(_filterlist);
    notifyListeners();

}



}