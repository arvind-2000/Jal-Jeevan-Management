import '../entities/waterlevelentity.dart';

abstract class WaterLevelRepositories{

  List<WaterLevel> getWaterLevel({ required String url});

}