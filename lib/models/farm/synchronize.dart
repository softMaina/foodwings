import '../farmers/farmer.dart';
import '../farmers/view_farmer.dart';

class Synchronize {
  /*
   {
      "farmer": "",
      "msisdn": "",
      "district_id": "",
      "area": "",
      "farms":[
        {
          "district_id":"",
          "crop_id":"",
          "area":"",
          "planting_date":"",
          "ploughing_date":"",
          "coordinates":""
        }
      ]
    }
   */
  late List<Farm> farms;
  late Farmer farmer;

  Synchronize(this.farms, this.farmer);

  Map<String, dynamic> toMap(){
    return  {
      "name": farmer.name,
      "msisdn": farmer.msisdn,
      "district_id": farmer.districtId,
      "area": farmer.area,
      "farms": farms
    };
  }
}
