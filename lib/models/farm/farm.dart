class Farm {
  int? id;
  int farmerId;
  int districtId;
  int cropId;
  String area;
  String plantingDate;
  String ploughingDate;
  String coordinates;

  Farm(this.farmerId, this.districtId, this.cropId, this.area,
      this.plantingDate, this.ploughingDate, this.coordinates,{this.id});


  Map<String, dynamic> toMap() {
    return {
      "id":id,
      "farmer_id": farmerId,
      "district_id": districtId,
      "crop_id": cropId,
      "area": area,
      "planting_date": plantingDate,
      "ploughing_date": ploughingDate,
      "coordinates": coordinates
    };
  }
}
