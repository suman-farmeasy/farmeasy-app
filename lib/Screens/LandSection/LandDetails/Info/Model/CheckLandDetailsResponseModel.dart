import 'dart:convert';
/// detail : "Operation Successful"
/// result : {"is_land_type_added":false,"is_water_source_added":true,"is_accomodation_added":false,"is_equipment_added":false,"is_land_farmed_added":false,"is_road_access_added":false,"is_organic_certification_added":false,"is_land_photo_added":false}

CheckLandDetailsResponseModel checkLandDetailsResponseModelFromJson(String str) => CheckLandDetailsResponseModel.fromJson(json.decode(str));
String checkLandDetailsResponseModelToJson(CheckLandDetailsResponseModel data) => json.encode(data.toJson());
class CheckLandDetailsResponseModel {
  CheckLandDetailsResponseModel({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  CheckLandDetailsResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
CheckLandDetailsResponseModel copyWith({  String? detail,
  Result? result,
}) => CheckLandDetailsResponseModel(  detail: detail ?? _detail,
  result: result ?? _result,
);
  String? get detail => _detail;
  Result? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['detail'] = _detail;
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    return map;
  }

}

/// is_land_type_added : false
/// is_water_source_added : true
/// is_accomodation_added : false
/// is_equipment_added : false
/// is_land_farmed_added : false
/// is_road_access_added : false
/// is_organic_certification_added : false
/// is_land_photo_added : false

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      bool? isLandTypeAdded, 
      bool? isWaterSourceAdded, 
      bool? isAccomodationAdded, 
      bool? isEquipmentAdded, 
      bool? isLandFarmedAdded, 
      bool? isRoadAccessAdded, 
      bool? isOrganicCertificationAdded, 
      bool? isLandPhotoAdded,}){
    _isLandTypeAdded = isLandTypeAdded;
    _isWaterSourceAdded = isWaterSourceAdded;
    _isAccomodationAdded = isAccomodationAdded;
    _isEquipmentAdded = isEquipmentAdded;
    _isLandFarmedAdded = isLandFarmedAdded;
    _isRoadAccessAdded = isRoadAccessAdded;
    _isOrganicCertificationAdded = isOrganicCertificationAdded;
    _isLandPhotoAdded = isLandPhotoAdded;
}

  Result.fromJson(dynamic json) {
    _isLandTypeAdded = json['is_land_type_added'];
    _isWaterSourceAdded = json['is_water_source_added'];
    _isAccomodationAdded = json['is_accomodation_added'];
    _isEquipmentAdded = json['is_equipment_added'];
    _isLandFarmedAdded = json['is_land_farmed_added'];
    _isRoadAccessAdded = json['is_road_access_added'];
    _isOrganicCertificationAdded = json['is_organic_certification_added'];
    _isLandPhotoAdded = json['is_land_photo_added'];
  }
  bool? _isLandTypeAdded;
  bool? _isWaterSourceAdded;
  bool? _isAccomodationAdded;
  bool? _isEquipmentAdded;
  bool? _isLandFarmedAdded;
  bool? _isRoadAccessAdded;
  bool? _isOrganicCertificationAdded;
  bool? _isLandPhotoAdded;
Result copyWith({  bool? isLandTypeAdded,
  bool? isWaterSourceAdded,
  bool? isAccomodationAdded,
  bool? isEquipmentAdded,
  bool? isLandFarmedAdded,
  bool? isRoadAccessAdded,
  bool? isOrganicCertificationAdded,
  bool? isLandPhotoAdded,
}) => Result(  isLandTypeAdded: isLandTypeAdded ?? _isLandTypeAdded,
  isWaterSourceAdded: isWaterSourceAdded ?? _isWaterSourceAdded,
  isAccomodationAdded: isAccomodationAdded ?? _isAccomodationAdded,
  isEquipmentAdded: isEquipmentAdded ?? _isEquipmentAdded,
  isLandFarmedAdded: isLandFarmedAdded ?? _isLandFarmedAdded,
  isRoadAccessAdded: isRoadAccessAdded ?? _isRoadAccessAdded,
  isOrganicCertificationAdded: isOrganicCertificationAdded ?? _isOrganicCertificationAdded,
  isLandPhotoAdded: isLandPhotoAdded ?? _isLandPhotoAdded,
);
  bool? get isLandTypeAdded => _isLandTypeAdded;
  bool? get isWaterSourceAdded => _isWaterSourceAdded;
  bool? get isAccomodationAdded => _isAccomodationAdded;
  bool? get isEquipmentAdded => _isEquipmentAdded;
  bool? get isLandFarmedAdded => _isLandFarmedAdded;
  bool? get isRoadAccessAdded => _isRoadAccessAdded;
  bool? get isOrganicCertificationAdded => _isOrganicCertificationAdded;
  bool? get isLandPhotoAdded => _isLandPhotoAdded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_land_type_added'] = _isLandTypeAdded;
    map['is_water_source_added'] = _isWaterSourceAdded;
    map['is_accomodation_added'] = _isAccomodationAdded;
    map['is_equipment_added'] = _isEquipmentAdded;
    map['is_land_farmed_added'] = _isLandFarmedAdded;
    map['is_road_access_added'] = _isRoadAccessAdded;
    map['is_organic_certification_added'] = _isOrganicCertificationAdded;
    map['is_land_photo_added'] = _isLandPhotoAdded;
    return map;
  }

}