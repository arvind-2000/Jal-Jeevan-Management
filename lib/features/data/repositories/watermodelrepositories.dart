import 'package:waterlevelmonitor/core/dummy.dart';

import '../../domain/entities/waterlevelentity.dart';
import '../../domain/repositories/waterlevelrepositories.dart';

class WaterLevelModelRepositories implements WaterLevelRepositories{
  
  
  @override
  List<WaterLevel> getWaterLevel({required String url}) {
      return waterleveldummy;
  }




}