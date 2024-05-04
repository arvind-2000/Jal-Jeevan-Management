class WaterAcidityEntity{

  double chlorine;
  double ph;
  double turbidity;
  DateTime dateTime;

  WaterAcidityEntity({
    required this.chlorine,
    required this.ph,
    required this.turbidity,
    required this.dateTime
  });

}


WaterAcidityEntity nw = WaterAcidityEntity(chlorine: 12, ph: 12, turbidity: 15,dateTime: DateTime(2024,1,2,3,4,5));