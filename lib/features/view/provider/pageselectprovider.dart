import 'package:flutter/material.dart';

class PageSelectProvider with ChangeNotifier{

    int pageSelect = 0 ;


    void changePage(int value){

          pageSelect = value;
          notifyListeners();

    
    }



}