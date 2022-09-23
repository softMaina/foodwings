import 'dart:convert';

List<RegionsModel> regionsModelFromJson(String str) => List<RegionsModel>.from(
    json.decode(str).map((x) => RegionsModel.fromJson(x)));

String regionsModelToJson(List<RegionsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegionsModel {
  RegionsModel({
    this.regionId,
    this.regionName,
    this.districts,
  });

  String? regionId;
  String? regionName;
  List<District>? districts;

  factory RegionsModel.fromJson(Map<String, dynamic> json) => RegionsModel(
        regionId: json["region_id"],
        regionName: json["region_name"],
        districts: List<District>.from(
            json["districts"].map((x) => District.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "region_id": regionId,
        "region_name": regionName,
        "districts": List<dynamic>.from(districts!.map((x) => x.toJson())),
      };
}

class District {
  District({
    this.districtId,
    this.districtName,
  });

  String? districtId;
  String? districtName;

  factory District.fromJson(Map<String, dynamic> json) => District(
        districtId: json["district_id"],
        districtName: json["district_name"],
      );

  Map<String, dynamic> toJson() => {
        "district_id": districtId,
        "district_name": districtName,
      };
}
