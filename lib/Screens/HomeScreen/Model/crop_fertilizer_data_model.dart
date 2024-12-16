class CropFertilizerDataModel {
  String? detail;
  Result? result;

  CropFertilizerDataModel({this.detail, this.result});

  CropFertilizerDataModel.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detail'] = this.detail;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? cropType;
  int? nitrogen;
  int? phosphorus;
  int? potassium;

  Result({this.cropType, this.nitrogen, this.phosphorus, this.potassium});

  Result.fromJson(Map<String, dynamic> json) {
    cropType = json['crop_type'];
    nitrogen = json['nitrogen'];
    phosphorus = json['phosphorus'];
    potassium = json['potassium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['crop_type'] = this.cropType;
    data['nitrogen'] = this.nitrogen;
    data['phosphorus'] = this.phosphorus;
    data['potassium'] = this.potassium;
    return data;
  }
}
