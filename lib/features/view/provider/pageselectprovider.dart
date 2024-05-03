import 'package:flutter/material.dart';

class PageSelectProvider with ChangeNotifier{

    int pageSelect = 0 ;
    bool filterselect = false;

    void changePage(int value){

          pageSelect = value;
          notifyListeners();

    
    }


    void changeFilter(){

          filterselect = !filterselect;
          notifyListeners();

    
    }

}