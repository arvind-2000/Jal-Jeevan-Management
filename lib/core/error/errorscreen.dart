import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waterlevelmonitor/core/const.dart';
import 'package:waterlevelmonitor/features/view/provider/waterlevelprovider.dart';
import 'package:waterlevelmonitor/features/view/widgets/cardoption.dart';
import 'package:waterlevelmonitor/features/view/widgets/cardstyle.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<WaterLevelProvider>(context);
    return Center(
      child:prov.isLoading?CircularProgressIndicator(

        backgroundColor: Theme.of(context).colorScheme.secondary,
      ) :CardStyle(
        child: Container(
          padding: EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(vertical: 60),
          width: 300,
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
           
            children: [
               Text(prov.response==4?servererror:interneterror,style:const TextStyle(fontSize: 20),textAlign:TextAlign.center,),
              const SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  prov.getDatass();
                },
                child: CardOptionBorder(title:'Tap to Retry',isSelect: true,))
            ],
          ),
        ),
      ),
    );
  }
}