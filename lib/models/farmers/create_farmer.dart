import 'package:meta/meta.dart';
import 'dart:convert';

CreateFarmer createFarmerFromJson(String str) => CreateFarmer.fromJson(json.decode(str));

String createFarmerToJson(CreateFarmer data) => json.encode(data.toJson());

class CreateFarmer {
    CreateFarmer({
      
        required this.farmerName,
        required this.msisdn,
        required this.districtId,
        required this.area,
    });
    final String farmerName;
    final String msisdn;
    final int districtId;
    final String area;

    CreateFarmer copyWith({
        required String farmerName,
        required String msisdn,
        required int districtId,
        required String area,
    }) => 
        CreateFarmer(
            farmerName: farmerName,
            msisdn: msisdn,
            districtId: districtId,
            area: area,
        );

    factory CreateFarmer.fromJson(Map<String, dynamic> json) => CreateFarmer(
        farmerName: json["farmer_name"],
        msisdn: json["msisdn"],
        districtId: json["district_id"],
        area: json["area"],
    );

    Map<String, dynamic> toJson() => {
        "farmer_name": farmerName,
        "msisdn": msisdn,
        "district_id": districtId,
        "area": area,
    };
}
