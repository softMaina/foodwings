import 'package:intl/intl.dart';

class Farmer{
  int? id;
  String name;
  String msisdn;
  int districtId;
  String area;


  Farmer(this.name, this.msisdn, this.districtId, this.area,{this.id});

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'name': name,
      'msisdn': msisdn,
      'district_id': districtId,
      'area': area
    };
  }
}