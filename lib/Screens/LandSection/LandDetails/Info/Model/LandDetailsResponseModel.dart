import 'dart:convert';
/// detail : "Operation Successful"
/// result : {"latitude":"17.2","longitude":"10.6","land_size":"2 acre","address":"Shankar nagar","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"},{"id":5,"name":"Potato"}],"purpose":{"id":2,"name":"Monetization"},"land_type":{"name":""},"water_source_available":false,"water_source":{"name":""},"accomodation_available":false,"accomodation":null,"equipment_available":false,"equipment":null,"land_farmed_before":false,"crops_grown":[{"id":2,"name":"Wheat"},{"id":4,"name":"Oats"},{"id":5,"name":"Potato"}],"additional_information":null,"road_access":false,"organic_certification":false,"certification_documnet":null}

LandDetailsResponseModel landDetailsResponseModelFromJson(String str) => LandDetailsResponseModel.fromJson(json.decode(str));
String landDetailsResponseModelToJson(LandDetailsResponseModel data) => json.encode(data.toJson());
class LandDetailsResponseModel {
  LandDetailsResponseModel({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  LandDetailsResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
LandDetailsResponseModel copyWith({  String? detail,
  Result? result,
}) => LandDetailsResponseModel(  detail: detail ?? _detail,
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

/// latitude : "17.2"
/// longitude : "10.6"
/// land_size : "2 acre"
/// address : "Shankar nagar"
/// crop_to_grow : [{"id":1,"name":"Maize"},{"id":3,"name":"Rice"},{"id":5,"name":"Potato"}]
/// purpose : {"id":2,"name":"Monetization"}
/// land_type : {"name":""}
/// water_source_available : false
/// water_source : {"name":""}
/// accomodation_available : false
/// accomodation : null
/// equipment_available : false
/// equipment : null
/// land_farmed_before : false
/// crops_grown : [{"id":2,"name":"Wheat"},{"id":4,"name":"Oats"},{"id":5,"name":"Potato"}]
/// additional_information : null
/// road_access : false
/// organic_certification : false
/// certification_documnet : null

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      String? latitude, 
      String? longitude, 
      String? landSize, 
      String? address,
      int? landId,
      List<CropToGrow>? cropToGrow, 
      Purpose? purpose, 
      LandType? landType, 
      bool? waterSourceAvailable, 
      WaterSource? waterSource, 
      bool? accomodationAvailable, 
      dynamic accomodation, 
      bool? equipmentAvailable, 
      dynamic equipment, 
      bool? landFarmedBefore, 
      List<CropsGrown>? cropsGrown, 
      dynamic additionalInformation, 
      bool? roadAccess,
    String? leaseType,
      bool? organicCertification, 
      String? leaseDuration,
      dynamic certificationDocumnet,}){
    _latitude = latitude;
    _longitude = longitude;
    _landSize = landSize;
    _leaseDuration = leaseDuration;
    _address = address;
    _cropToGrow = cropToGrow;
    _purpose = purpose;
    _landType = landType;
    _landId= landId;
    _waterSourceAvailable = waterSourceAvailable;
    _waterSource = waterSource;
    _accomodationAvailable = accomodationAvailable;
    _accomodation = accomodation;
    _equipmentAvailable = equipmentAvailable;
    _equipment = equipment;
    _landFarmedBefore = landFarmedBefore;
    _cropsGrown = cropsGrown;
    _additionalInformation = additionalInformation;
    _roadAccess = roadAccess;
    _organicCertification = organicCertification;
    _certificationDocumnet = certificationDocumnet;
    _leaseType =leaseType;
}

  Result.fromJson(dynamic json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _landSize = json['land_size'];
    _address = json['address'];
    _landId = json['land_id'];
    _leaseDuration = json['lease_duration'];
    if (json['crop_to_grow'] != null) {
      _cropToGrow = [];
      json['crop_to_grow'].forEach((v) {
        _cropToGrow?.add(CropToGrow.fromJson(v));
      });
    }
    _purpose = json['purpose'] != null ? Purpose.fromJson(json['purpose']) : null;
    _landType = json['land_type'] != null ? LandType.fromJson(json['land_type']) : null;
    _waterSourceAvailable = json['water_source_available'];
    _waterSource = json['water_source'] != null ? WaterSource.fromJson(json['water_source']) : null;
    _accomodationAvailable = json['accomodation_available'];
    _accomodation = json['accomodation'];
    _equipmentAvailable = json['equipment_available'];
    _equipment = json['equipment'];
    _landFarmedBefore = json['land_farmed_before'];
    if (json['crops_grown'] != null) {
      _cropsGrown = [];
      json['crops_grown'].forEach((v) {
        _cropsGrown?.add(CropsGrown.fromJson(v));
      });
    }
    _additionalInformation = json['additional_information'];
    _roadAccess = json['road_access'];
    _organicCertification = json['organic_certification'];
    _certificationDocumnet = json['certification_documnet'];
    _leaseType = json['lease_type'];
  }
  String? _latitude;
  String? _longitude;
  String? _landSize;
  String? _address;
  String? _leaseType;
  String? _leaseDuration;
  List<CropToGrow>? _cropToGrow;
  Purpose? _purpose;
  LandType? _landType;
  bool? _waterSourceAvailable;
  WaterSource? _waterSource;
  int? _landId;
  bool? _accomodationAvailable;
  dynamic _accomodation;
  bool? _equipmentAvailable;
  dynamic _equipment;
  bool? _landFarmedBefore;
  List<CropsGrown>? _cropsGrown;
  dynamic _additionalInformation;
  bool? _roadAccess;
  bool? _organicCertification;
  dynamic _certificationDocumnet;
Result copyWith({  String? latitude,
  String? longitude,
  String? landSize,
  String? address,
  int?landId,
  String? leaseDuration,
  List<CropToGrow>? cropToGrow,
  Purpose? purpose,
  LandType? landType,
  bool? waterSourceAvailable,
  WaterSource? waterSource,
  bool? accomodationAvailable,
  dynamic accomodation,
  bool? equipmentAvailable,
  dynamic equipment,
  bool? landFarmedBefore,
  List<CropsGrown>? cropsGrown,
  dynamic additionalInformation,
  bool? roadAccess,
  bool? organicCertification,
  dynamic certificationDocumnet,
  String ? leaseType,
}) => Result(  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  landSize: landSize ?? _landSize,
  address: address ?? _address,
  leaseType: leaseType ?? _leaseType,
  leaseDuration: leaseDuration ?? _leaseDuration,
  landId: landId??_landId,
  cropToGrow: cropToGrow ?? _cropToGrow,
  purpose: purpose ?? _purpose,
  landType: landType ?? _landType,
  waterSourceAvailable: waterSourceAvailable ?? _waterSourceAvailable,
  waterSource: waterSource ?? _waterSource,
  accomodationAvailable: accomodationAvailable ?? _accomodationAvailable,
  accomodation: accomodation ?? _accomodation,
  equipmentAvailable: equipmentAvailable ?? _equipmentAvailable,
  equipment: equipment ?? _equipment,
  landFarmedBefore: landFarmedBefore ?? _landFarmedBefore,
  cropsGrown: cropsGrown ?? _cropsGrown,
  additionalInformation: additionalInformation ?? _additionalInformation,
  roadAccess: roadAccess ?? _roadAccess,
  organicCertification: organicCertification ?? _organicCertification,
  certificationDocumnet: certificationDocumnet ?? _certificationDocumnet,
);
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get landSize => _landSize;
  String? get address => _address;
  String? get leaseType => _leaseType;
  String? get leaseDuration => _leaseDuration;
  int? get landId => _landId;
  List<CropToGrow>? get cropToGrow => _cropToGrow;
  Purpose? get purpose => _purpose;
  LandType? get landType => _landType;
  bool? get waterSourceAvailable => _waterSourceAvailable;
  WaterSource? get waterSource => _waterSource;
  bool? get accomodationAvailable => _accomodationAvailable;
  dynamic get accomodation => _accomodation;
  bool? get equipmentAvailable => _equipmentAvailable;
  dynamic get equipment => _equipment;
  bool? get landFarmedBefore => _landFarmedBefore;
  List<CropsGrown>? get cropsGrown => _cropsGrown;
  dynamic get additionalInformation => _additionalInformation;
  bool? get roadAccess => _roadAccess;
  bool? get organicCertification => _organicCertification;
  dynamic get certificationDocumnet => _certificationDocumnet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['land_size'] = _landSize;
    map['address'] = _address;
    map['lease_type'] = _leaseType;
    map['lease_duration'] = _leaseDuration;
    map['land_id'] = _landId;
    if (_cropToGrow != null) {
      map['crop_to_grow'] = _cropToGrow?.map((v) => v.toJson()).toList();
    }
    if (_purpose != null) {
      map['purpose'] = _purpose?.toJson();
    }
    if (_landType != null) {
      map['land_type'] = _landType?.toJson();
    }
    map['water_source_available'] = _waterSourceAvailable;
    if (_waterSource != null) {
      map['water_source'] = _waterSource?.toJson();
    }
    map['accomodation_available'] = _accomodationAvailable;
    map['accomodation'] = _accomodation;
    map['equipment_available'] = _equipmentAvailable;
    map['equipment'] = _equipment;
    map['land_farmed_before'] = _landFarmedBefore;
    if (_cropsGrown != null) {
      map['crops_grown'] = _cropsGrown?.map((v) => v.toJson()).toList();
    }
    map['additional_information'] = _additionalInformation;
    map['road_access'] = _roadAccess;
    map['organic_certification'] = _organicCertification;
    map['certification_documnet'] = _certificationDocumnet;
    return map;
  }

}

/// id : 2
/// name : "Wheat"

CropsGrown cropsGrownFromJson(String str) => CropsGrown.fromJson(json.decode(str));
String cropsGrownToJson(CropsGrown data) => json.encode(data.toJson());
class CropsGrown {
  CropsGrown({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  CropsGrown.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
CropsGrown copyWith({  num? id,
  String? name,
}) => CropsGrown(  id: id ?? _id,
  name: name ?? _name,
);
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}

/// name : ""

WaterSource waterSourceFromJson(String str) => WaterSource.fromJson(json.decode(str));
String waterSourceToJson(WaterSource data) => json.encode(data.toJson());
class WaterSource {
  WaterSource({
      String? name,}){
    _name = name;
}

  WaterSource.fromJson(dynamic json) {
    _name = json['name'];
  }
  String? _name;
WaterSource copyWith({  String? name,
}) => WaterSource(  name: name ?? _name,
);
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }

}

/// name : ""

LandType landTypeFromJson(String str) => LandType.fromJson(json.decode(str));
String landTypeToJson(LandType data) => json.encode(data.toJson());
class LandType {
  LandType({
      String? name,}){
    _name = name;
}

  LandType.fromJson(dynamic json) {
    _name = json['name'];
  }
  String? _name;
LandType copyWith({  String? name,
}) => LandType(  name: name ?? _name,
);
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    return map;
  }

}

/// id : 2
/// name : "Monetization"

Purpose purposeFromJson(String str) => Purpose.fromJson(json.decode(str));
String purposeToJson(Purpose data) => json.encode(data.toJson());
class Purpose {
  Purpose({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Purpose.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
Purpose copyWith({  num? id,
  String? name,
}) => Purpose(  id: id ?? _id,
  name: name ?? _name,
);
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}

/// id : 1
/// name : "Maize"

CropToGrow cropToGrowFromJson(String str) => CropToGrow.fromJson(json.decode(str));
String cropToGrowToJson(CropToGrow data) => json.encode(data.toJson());
class CropToGrow {
  CropToGrow({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  CropToGrow.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
CropToGrow copyWith({  num? id,
  String? name,
}) => CropToGrow(  id: id ?? _id,
  name: name ?? _name,
);
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}