import 'package:farm_easy/Screens/LandSection/Recomended%20Land%20Detatils/Model/RecommendedLandDetailsResponseModel.dart';

class EditLandDetailsResponseModel {
  String? detail;
  Result? result;

  EditLandDetailsResponseModel({this.detail, this.result});

  EditLandDetailsResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? landId;
  String? latitude;
  String? longitude;
  String? landSize;
  String? address;
  List<CropToGrow>? cropToGrow;
  CropToGrow? purpose;
  CropToGrow? landType;
  bool? waterSourceAvailable;
  CropToGrow? waterSource;
  bool? accomodationAvailable;
  String? accomodation;
  bool? equipmentAvailable;
  String? equipment;
  bool? landFarmedBefore;
  List<CropsGrown>? cropsGrown;
  String? additionalInformation;
  bool? roadAccess;
  bool? organicCertification;
  String? certificationDocumnet;
  String? leaseDuration;
  String? leaseType;
  String? expectedLeaseAmount;

  Result(
      {this.landId,
      this.latitude,
      this.longitude,
      this.landSize,
      this.address,
      this.cropToGrow,
      this.purpose,
      this.landType,
      this.waterSourceAvailable,
      this.waterSource,
      this.accomodationAvailable,
      this.accomodation,
      this.equipmentAvailable,
      this.equipment,
      this.landFarmedBefore,
      this.cropsGrown,
      this.additionalInformation,
      this.roadAccess,
      this.organicCertification,
      this.certificationDocumnet,
      this.leaseDuration,
      this.leaseType,
      this.expectedLeaseAmount});

  Result.fromJson(Map<String, dynamic> json) {
    landId = json['land_id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    landSize = json['land_size'];
    address = json['address'];
    if (json['crop_to_grow'] != null) {
      cropToGrow = <CropToGrow>[];
      json['crop_to_grow'].forEach((v) {
        cropToGrow!.add(new CropToGrow.fromJson(v));
      });
    }
    purpose = json['purpose'] != null
        ? new CropToGrow.fromJson(json['purpose'])
        : null;
    landType = json['land_type'] != null
        ? new CropToGrow.fromJson(json['land_type'])
        : null;
    waterSourceAvailable = json['water_source_available'];
    waterSource = json['water_source'] != null
        ? new CropToGrow.fromJson(json['water_source'])
        : null;
    accomodationAvailable = json['accomodation_available'];
    accomodation = json['accomodation'];
    equipmentAvailable = json['equipment_available'];
    equipment = json['equipment'];
    landFarmedBefore = json['land_farmed_before'];
    if (json['crops_grown'] != null) {
      cropsGrown = <CropsGrown>[];
      json['crops_grown'].forEach((v) {
        cropsGrown!.add(new CropsGrown.fromJson(v));
      });
    }
    additionalInformation = json['additional_information'];
    roadAccess = json['road_access'];
    organicCertification = json['organic_certification'];
    certificationDocumnet = json['certification_documnet'];
    leaseDuration = json['lease_duration'];
    leaseType = json['lease_type'];
    expectedLeaseAmount = json['expected_lease_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['land_id'] = this.landId;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['land_size'] = this.landSize;
    data['address'] = this.address;
    if (this.cropToGrow != null) {
      data['crop_to_grow'] = this.cropToGrow!.map((v) => v.toJson()).toList();
    }
    if (this.purpose != null) {
      data['purpose'] = this.purpose!.toJson();
    }
    if (this.landType != null) {
      data['land_type'] = this.landType!.toJson();
    }
    data['water_source_available'] = this.waterSourceAvailable;
    if (this.waterSource != null) {
      data['water_source'] = this.waterSource!.toJson();
    }
    data['accomodation_available'] = this.accomodationAvailable;
    data['accomodation'] = this.accomodation;
    data['equipment_available'] = this.equipmentAvailable;
    data['equipment'] = this.equipment;
    data['land_farmed_before'] = this.landFarmedBefore;
    if (this.cropsGrown != null) {
      data['crops_grown'] = this.cropsGrown!.map((v) => v.toJson()).toList();
    }
    data['additional_information'] = this.additionalInformation;
    data['road_access'] = this.roadAccess;
    data['organic_certification'] = this.organicCertification;
    data['certification_documnet'] = this.certificationDocumnet;
    data['lease_duration'] = this.leaseDuration;
    data['lease_type'] = this.leaseType;
    data['expected_lease_amount'] = this.expectedLeaseAmount;
    return data;
  }
}

class CropToGrow {
  int? id;
  String? name;

  CropToGrow({this.id, this.name});

  CropToGrow.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
