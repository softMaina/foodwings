import 'dart:convert';

CreateFarmModel CreateFarmModelFromJson(String str) =>
    CreateFarmModel.fromJson(json.decode(str));

String createFarmModelToJson(CreateFarmModel data) =>
    json.encode(data.toJson());

class CreateFarmModel {
  CreateFarmModel({
    required this.farmerId,
    required this.districtId,
    required this.cropId,
    required this.area,
    required this.plantingDate,
    required this.ploughingDate,
    required this.coordinates,
  });

  final int farmerId;
  final int districtId;
  final int cropId;
  final DateTime plantingDate;
  final DateTime ploughingDate;
  final String area;
  final List<Coordinate> coordinates;

  factory CreateFarmModel.fromJson(Map<String, dynamic> json) =>
      CreateFarmModel(
        farmerId: json["farmer_id"],
        districtId: json["district_id"],
        cropId: json["district_id"],
        ploughingDate: DateTime.parse(json["ploughing_date"]),
        plantingDate: DateTime.parse(json["planting_date:"]),
        area: json["area"],
        coordinates: List<Coordinate>.from(
            json["coordinates"].map((x) => Coordinate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "farmer_id": farmerId,
        "district_id": districtId,
        "crop_id": cropId,
        "ploughing_date": ploughingDate.toIso8601String(),
        "planting_date:": plantingDate.toIso8601String(),
        "area": area,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x.toJson())),
      };
}

class Coordinate {
  Coordinate({
    required this.longitude,
    required this.latitude,
  });

  late double longitude;
  late double latitude;

  factory Coordinate.fromJson(Map<String, dynamic> json) => Coordinate(
        longitude: json["longitude"],
        latitude: json["latitude"],
      );

  Map<String, dynamic> toJson() => {
        "longitude": longitude,
        "latitude": latitude,
      };
}
