import 'dart:convert';

List<ViewFarmerModel> viewFarmerModelFromJson(String str) =>
    List<ViewFarmerModel>.from(
        json.decode(str).map((x) => ViewFarmerModel.fromJson(x)));

String viewFarmerModelToJson(List<ViewFarmerModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ViewFarmerModel {
  ViewFarmerModel({
    this.id,
    this.farmerName,
    this.msisdn,
    this.franchiseId,
    this.regionId,
    this.districtId,
    this.area,
    this.created,
    this.updated,
    this.farms,
  });

  String? id;
  String? farmerName;
  String? msisdn;
  String? franchiseId;
  String? regionId;
  String? districtId;
  String? area;
  DateTime? created;
  DateTime? updated;
  List<Farm>? farms;

  factory ViewFarmerModel.fromJson(Map<String, dynamic> json) =>
      ViewFarmerModel(
        id: json["id"],
        farmerName: json["farmer_name"],
        msisdn: json["msisdn"],
        franchiseId: json["franchise_id"],
        regionId: json["region_id"],
        districtId: json["district_id"],
        area: json["area"],
        created: DateTime.parse(json["created"]),
        updated: DateTime.parse(json["updated"]),
        farms: List<Farm>.from(json["farms"].map((x) => Farm.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "farmer_name": farmerName,
        "msisdn": msisdn,
        "franchise_id": franchiseId,
        "region_id": regionId,
        "district_id": districtId,
        "area": area,
        "created": created!.toIso8601String(),
        "updated": updated!.toIso8601String(),
        "farms": List<dynamic>.from(farms!.map((x) => x.toJson())),
      };
}

class Farm {
  Farm({
    this.regionId,
    this.districtId,
    this.area,
    this.farmSize,
    this.coordinates,
  });

  String? regionId;
  String? districtId;
  String? area;
  String? farmSize;
  List<Coordinate>? coordinates;

  factory Farm.fromJson(Map<String, dynamic> json) => Farm(
        regionId: json["region_id"],
        districtId: json["district_id"],
        area: json["area"],
        farmSize: json["farm_size"],
        coordinates: List<Coordinate>.from(
            json["coordinates"].map((x) => Coordinate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "region_id": regionId,
        "district_id": districtId,
        "area": area,
        "farm_size": farmSize,
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x.toJson())),
      };
}

class Coordinate {
  Coordinate({
    this.longitude,
    this.latitude,
  });

  dynamic longitude;
  dynamic latitude;

  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
      };
}
