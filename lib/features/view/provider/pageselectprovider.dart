import 'package:flutter/material.dart';

class PageSelectProvider with ChangeNotifier{

    int pageSelect = 0 ;
    bool filterselect = false;
    int pageswap = 0;
    int reportpageswap = 0;
    void changePage(int value){

          pageSelect = value;
          notifyListeners();

    
    }


  void changegraphpage(){
    
    pageswap = (pageswap+1)%4;
    notifyListeners();

  }
  void changereportpage(){
    
    reportpageswap = (reportpageswap +1)%3;
    notifyListeners();

  }
    void changeFilter(){

          filterselect = !filterselect;
          notifyListeners();

    
    }

}