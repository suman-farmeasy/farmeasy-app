import 'dart:convert';
/// detail : "Operation Successful"
/// result : {"land_owner_user_id":85,"land_owner_user_type":"Land Owner","land_owner_name":"sahil","land_owner_image":"http://139.5.189.24:8000/media/user_image/image_cropper_1710999115199.jpg","land_owner_location":"Pandri, Raipur, Chhattisgarh, India","land_images":[{"image":"http://139.5.189.24:8000/media/land_images/1000042880_HrRfnhB.jpg"}],"latitude":"34.0762","longitude":"-118.2607","land_size":"10 Acres","address":"3rd floor","crop_to_grow":[{"id":1,"name":"Maize"},{"id":5,"name":"Potato"}],"purpose":{"id":3,"name":"Food security"},"land_type":{"id":2,"name":"Paddy field"},"water_source_available":true,"water_source":{"id":2,"name":"Irrigation system"},"accomodation_available":true,"accomodation":"hgfhg","equipment_available":true,"equipment":"xyz","land_farmed_before":true,"crops_grown":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"},{"id":4,"name":"Oats"}],"additional_information":"ghhgfgh","road_access":true,"organic_certification":true,"certification_documnet":"http://139.5.189.24:8000/media/land_file/photo.jpg","enquiry_id":null}

RecommendedLandDetailsResponseModel recommendedLandDetailsResponseModelFromJson(String str) => RecommendedLandDetailsResponseModel.fromJson(json.decode(str));
String recommendedLandDetailsResponseModelToJson(RecommendedLandDetailsResponseModel data) => json.encode(data.toJson());
class RecommendedLandDetailsResponseModel {
  RecommendedLandDetailsResponseModel({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  RecommendedLandDetailsResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
RecommendedLandDetailsResponseModel copyWith({  String? detail,
  Result? result,
}) => RecommendedLandDetailsResponseModel(  detail: detail ?? _detail,
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

/// land_owner_user_id : 85
/// land_owner_user_type : "Land Owner"
/// land_owner_name : "sahil"
/// land_owner_image : "http://139.5.189.24:8000/media/user_image/image_cropper_1710999115199.jpg"
/// land_owner_location : "Pandri, Raipur, Chhattisgarh, India"
/// land_images : [{"image":"http://139.5.189.24:8000/media/land_images/1000042880_HrRfnhB.jpg"}]
/// latitude : "34.0762"
/// longitude : "-118.2607"
/// land_size : "10 Acres"
/// address : "3rd floor"
/// crop_to_grow : [{"id":1,"name":"Maize"},{"id":5,"name":"Potato"}]
/// purpose : {"id":3,"name":"Food security"}
/// land_type : {"id":2,"name":"Paddy field"}
/// water_source_available : true
/// water_source : {"id":2,"name":"Irrigation system"}
/// accomodation_available : true
/// accomodation : "hgfhg"
/// equipment_available : true
/// equipment : "xyz"
/// land_farmed_before : true
/// crops_grown : [{"id":1,"name":"Maize"},{"id":3,"name":"Rice"},{"id":4,"name":"Oats"}]
/// additional_information : "ghhgfgh"
/// road_access : true
/// organic_certification : true
/// certification_documnet : "http://139.5.189.24:8000/media/land_file/photo.jpg"
/// enquiry_id : null

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      num? landOwnerUserId, 
      String? landOwnerUserType, 
      String? landOwnerName, 
      String? landOwnerImage, 
      String? landOwnerLocation, 
      List<LandImages>? landImages, 
      String? latitude, 
      String? longitude, 
      String? landSize, 
      String? address, 
      List<CropToGrow>? cropToGrow, 
      Purpose? purpose, 
      LandType? landType, 
      bool? waterSourceAvailable, 
      WaterSource? waterSource, 
      bool? accomodationAvailable, 
      String? accomodation, 
      bool? equipmentAvailable, 
      String? equipment, 
      bool? landFarmedBefore, 
      List<CropsGrown>? cropsGrown, 
      String? additionalInformation, 
      bool? roadAccess, 
      bool? organicCertification, 
      String? certificationDocumnet, 
      dynamic enquiryId,}){
    _landOwnerUserId = landOwnerUserId;
    _landOwnerUserType = landOwnerUserType;
    _landOwnerName = landOwnerName;
    _landOwnerImage = landOwnerImage;
    _landOwnerLocation = landOwnerLocation;
    _landImages = landImages;
    _latitude = latitude;
    _longitude = longitude;
    _landSize = landSize;
    _address = address;
    _cropToGrow = cropToGrow;
    _purpose = purpose;
    _landType = landType;
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
    _enquiryId = enquiryId;
}

  Result.fromJson(dynamic json) {
    _landOwnerUserId = json['land_owner_user_id'];
    _landOwnerUserType = json['land_owner_user_type'];
    _landOwnerName = json['land_owner_name'];
    _landOwnerImage = json['land_owner_image'];
    _landOwnerLocation = json['land_owner_location'];
    if (json['land_images'] != null) {
      _landImages = [];
      json['land_images'].forEach((v) {
        _landImages?.add(LandImages.fromJson(v));
      });
    }
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _landSize = json['land_size'];
    _address = json['address'];
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
    _enquiryId = json['enquiry_id'];
  }
  num? _landOwnerUserId;
  String? _landOwnerUserType;
  String? _landOwnerName;
  String? _landOwnerImage;
  String? _landOwnerLocation;
  List<LandImages>? _landImages;
  String? _latitude;
  String? _longitude;
  String? _landSize;
  String? _address;
  List<CropToGrow>? _cropToGrow;
  Purpose? _purpose;
  LandType? _landType;
  bool? _waterSourceAvailable;
  WaterSource? _waterSource;
  bool? _accomodationAvailable;
  String? _accomodation;
  bool? _equipmentAvailable;
  String? _equipment;
  bool? _landFarmedBefore;
  List<CropsGrown>? _cropsGrown;
  String? _additionalInformation;
  bool? _roadAccess;
  bool? _organicCertification;
  String? _certificationDocumnet;
  dynamic _enquiryId;
Result copyWith({  num? landOwnerUserId,
  String? landOwnerUserType,
  String? landOwnerName,
  String? landOwnerImage,
  String? landOwnerLocation,
  List<LandImages>? landImages,
  String? latitude,
  String? longitude,
  String? landSize,
  String? address,
  List<CropToGrow>? cropToGrow,
  Purpose? purpose,
  LandType? landType,
  bool? waterSourceAvailable,
  WaterSource? waterSource,
  bool? accomodationAvailable,
  String? accomodation,
  bool? equipmentAvailable,
  String? equipment,
  bool? landFarmedBefore,
  List<CropsGrown>? cropsGrown,
  String? additionalInformation,
  bool? roadAccess,
  bool? organicCertification,
  String? certificationDocumnet,
  dynamic enquiryId,
}) => Result(  landOwnerUserId: landOwnerUserId ?? _landOwnerUserId,
  landOwnerUserType: landOwnerUserType ?? _landOwnerUserType,
  landOwnerName: landOwnerName ?? _landOwnerName,
  landOwnerImage: landOwnerImage ?? _landOwnerImage,
  landOwnerLocation: landOwnerLocation ?? _landOwnerLocation,
  landImages: landImages ?? _landImages,
  latitude: latitude ?? _latitude,
  longitude: longitude ?? _longitude,
  landSize: landSize ?? _landSize,
  address: address ?? _address,
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
  enquiryId: enquiryId ?? _enquiryId,
);
  num? get landOwnerUserId => _landOwnerUserId;
  String? get landOwnerUserType => _landOwnerUserType;
  String? get landOwnerName => _landOwnerName;
  String? get landOwnerImage => _landOwnerImage;
  String? get landOwnerLocation => _landOwnerLocation;
  List<LandImages>? get landImages => _landImages;
  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get landSize => _landSize;
  String? get address => _address;
  List<CropToGrow>? get cropToGrow => _cropToGrow;
  Purpose? get purpose => _purpose;
  LandType? get landType => _landType;
  bool? get waterSourceAvailable => _waterSourceAvailable;
  WaterSource? get waterSource => _waterSource;
  bool? get accomodationAvailable => _accomodationAvailable;
  String? get accomodation => _accomodation;
  bool? get equipmentAvailable => _equipmentAvailable;
  String? get equipment => _equipment;
  bool? get landFarmedBefore => _landFarmedBefore;
  List<CropsGrown>? get cropsGrown => _cropsGrown;
  String? get additionalInformation => _additionalInformation;
  bool? get roadAccess => _roadAccess;
  bool? get organicCertification => _organicCertification;
  String? get certificationDocumnet => _certificationDocumnet;
  dynamic get enquiryId => _enquiryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['land_owner_user_id'] = _landOwnerUserId;
    map['land_owner_user_type'] = _landOwnerUserType;
    map['land_owner_name'] = _landOwnerName;
    map['land_owner_image'] = _landOwnerImage;
    map['land_owner_location'] = _landOwnerLocation;
    if (_landImages != null) {
      map['land_images'] = _landImages?.map((v) => v.toJson()).toList();
    }
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['land_size'] = _landSize;
    map['address'] = _address;
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
    map['enquiry_id'] = _enquiryId;
    return map;
  }

}

/// id : 1
/// name : "Maize"

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

/// id : 2
/// name : "Irrigation system"

WaterSource waterSourceFromJson(String str) => WaterSource.fromJson(json.decode(str));
String waterSourceToJson(WaterSource data) => json.encode(data.toJson());
class WaterSource {
  WaterSource({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  WaterSource.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
WaterSource copyWith({  num? id,
  String? name,
}) => WaterSource(  id: id ?? _id,
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

/// id : 2
/// name : "Paddy field"

LandType landTypeFromJson(String str) => LandType.fromJson(json.decode(str));
String landTypeToJson(LandType data) => json.encode(data.toJson());
class LandType {
  LandType({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  LandType.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
LandType copyWith({  num? id,
  String? name,
}) => LandType(  id: id ?? _id,
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

/// id : 3
/// name : "Food security"

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

/// image : "http://139.5.189.24:8000/media/land_images/1000042880_HrRfnhB.jpg"

LandImages landImagesFromJson(String str) => LandImages.fromJson(json.decode(str));
String landImagesToJson(LandImages data) => json.encode(data.toJson());
class LandImages {
  LandImages({
      String? image,}){
    _image = image;
}

  LandImages.fromJson(dynamic json) {
    _image = json['image'];
  }
  String? _image;
LandImages copyWith({  String? image,
}) => LandImages(  image: image ?? _image,
);
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = _image;
    return map;
  }

}