import 'dart:convert';

CropModel cropModelFromJson(String str) => CropModel.fromJson(json.decode(str));

String cropModelToJson(CropModel data) => json.encode(data.toJson());

class CropModel {
    CropModel({
        this.status,
        this.data,
    });

    int? status;
    List<Datum>? data;

    factory CropModel.fromJson(Map<String, dynamic> json) => CropModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        this.id,
        this.fullname,
        this.shortnameEnglish,
        this.shortnameKiswahili,
        this.ussdPriority,
        this.status,
        this.farms,
        this.area,
    });

    String? id;
    String? fullname;
    String? shortnameEnglish;
    String? shortnameKiswahili;
    String? ussdPriority;
    String?status;
    String? farms;
    dynamic? area;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        fullname: json["fullname"],
        shortnameEnglish: json["shortname_english"],
        shortnameKiswahili: json["shortname_kiswahili"],
        ussdPriority: json["ussd_priority"],
        status: json["status"],
        farms: json["farms"],
        area: json["area"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "shortname_english": shortnameEnglish,
        "shortname_kiswahili": shortnameKiswahili,
        "ussd_priority": ussdPriority,
        "status": status,
        "farms": farms,
        "area": area,
    };
}
