import 'dart:convert';

/// detail : "Operation Successful"
/// result : {"matching_agri_service_providers":[{"id":6,"user_id":2,"user_type":"Agri Service Provider","full_name":"Yash Sharma","lives_in":"Pandri, Raipur, Chhattisgarh","roles":[{"id":1,"name":"Broker"},{"id":3,"name":"Lender"},{"id":4,"name":"Investor"},{"id":6,"name":"Property Officer"},{"id":9,"name":"Food Processors"}],"image":"http://139.5.189.24:8000/media/user_image/photo_AEZjpNZ.jpg","enquiry_id":null},{"id":8,"user_id":1,"user_type":"Farmer","full_name":"Aman","lives_in":"Raipur","roles":[{"id":2,"name":"Lawyer"},{"id":4,"name":"Investor"}],"image":"http://139.5.189.24:8000/media/user_image/photo_spE3lmH.jpg","enquiry_id":null},{"id":9,"user_id":43,"user_type":"Agri Service Provider","full_name":"Aman","lives_in":"Raipur","roles":[{"id":4,"name":"Investor"}],"image":"http://139.5.189.24:8000/media/user_image/photo_BkmErcZ.jpg","enquiry_id":null},{"id":10,"user_id":44,"user_type":"Agri Service Provider","full_name":"Yash Sharma","lives_in":"Raipur","roles":[{"id":3,"name":"Lender"},{"id":4,"name":"Investor"}],"image":"http://139.5.189.24:8000/media/user_image/photo_dN7SLCu.jpg","enquiry_id":null},{"id":11,"user_id":47,"user_type":"Agri Service Provider","full_name":"Aman tiwari","lives_in":"Mahasamund","roles":[{"id":1,"name":"Broker"},{"id":3,"name":"Lender"},{"id":6,"name":"Property Officer"}],"image":"http://139.5.189.24:8000/media/user_image/photo_mK0z18h.jpg","enquiry_id":null},{"id":12,"user_id":48,"user_type":"Agri Service Provider","full_name":"asd","lives_in":"Raipur","roles":[{"id":1,"name":"Broker"},{"id":3,"name":"Lender"},{"id":6,"name":"Property Officer"}],"image":"http://139.5.189.24:8000/media/user_image/photo_I22w78h.jpg","enquiry_id":null},{"id":13,"user_id":50,"user_type":"Agri Service Provider","full_name":"Yash Sharma","lives_in":"Raipur","roles":[{"id":3,"name":"Lender"},{"id":6,"name":"Property Officer"}],"image":"http://139.5.189.24:8000/media/user_image/photo_HVy8w7a.jpg","enquiry_id":null}],"count":7}

MatchingAgriProviderResponseModel matchingAgriProviderResponseModelFromJson(
        String str) =>
    MatchingAgriProviderResponseModel.fromJson(json.decode(str));
String matchingAgriProviderResponseModelToJson(
        MatchingAgriProviderResponseModel data) =>
    json.encode(data.toJson());

class MatchingAgriProviderResponseModel {
  MatchingAgriProviderResponseModel({
    String? detail,
    Result? result,
  }) {
    _detail = detail;
    _result = result;
  }

  MatchingAgriProviderResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
  MatchingAgriProviderResponseModel copyWith({
    String? detail,
    Result? result,
  }) =>
      MatchingAgriProviderResponseModel(
        detail: detail ?? _detail,
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

/// matching_agri_service_providers : [{"id":6,"user_id":2,"user_type":"Agri Service Provider","full_name":"Yash Sharma","lives_in":"Pandri, Raipur, Chhattisgarh","roles":[{"id":1,"name":"Broker"},{"id":3,"name":"Lender"},{"id":4,"name":"Investor"},{"id":6,"name":"Property Officer"},{"id":9,"name":"Food Processors"}],"image":"http://139.5.189.24:8000/media/user_image/photo_AEZjpNZ.jpg","enquiry_id":null},{"id":8,"user_id":1,"user_type":"Farmer","full_name":"Aman","lives_in":"Raipur","roles":[{"id":2,"name":"Lawyer"},{"id":4,"name":"Investor"}],"image":"http://139.5.189.24:8000/media/user_image/photo_spE3lmH.jpg","enquiry_id":null},{"id":9,"user_id":43,"user_type":"Agri Service Provider","full_name":"Aman","lives_in":"Raipur","roles":[{"id":4,"name":"Investor"}],"image":"http://139.5.189.24:8000/media/user_image/photo_BkmErcZ.jpg","enquiry_id":null},{"id":10,"user_id":44,"user_type":"Agri Service Provider","full_name":"Yash Sharma","lives_in":"Raipur","roles":[{"id":3,"name":"Lender"},{"id":4,"name":"Investor"}],"image":"http://139.5.189.24:8000/media/user_image/photo_dN7SLCu.jpg","enquiry_id":null},{"id":11,"user_id":47,"user_type":"Agri Service Provider","full_name":"Aman tiwari","lives_in":"Mahasamund","roles":[{"id":1,"name":"Broker"},{"id":3,"name":"Lender"},{"id":6,"name":"Property Officer"}],"image":"http://139.5.189.24:8000/media/user_image/photo_mK0z18h.jpg","enquiry_id":null},{"id":12,"user_id":48,"user_type":"Agri Service Provider","full_name":"asd","lives_in":"Raipur","roles":[{"id":1,"name":"Broker"},{"id":3,"name":"Lender"},{"id":6,"name":"Property Officer"}],"image":"http://139.5.189.24:8000/media/user_image/photo_I22w78h.jpg","enquiry_id":null},{"id":13,"user_id":50,"user_type":"Agri Service Provider","full_name":"Yash Sharma","lives_in":"Raipur","roles":[{"id":3,"name":"Lender"},{"id":6,"name":"Property Officer"}],"image":"http://139.5.189.24:8000/media/user_image/photo_HVy8w7a.jpg","enquiry_id":null}]
/// count : 7

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());

class Result {
  Result({
    List<MatchingAgriServiceProviders>? matchingAgriServiceProviders,
    num? count,
  }) {
    _matchingAgriServiceProviders = matchingAgriServiceProviders;
    _count = count;
  }

  Result.fromJson(dynamic json) {
    if (json['matching_agri_service_providers'] != null) {
      _matchingAgriServiceProviders = [];
      json['matching_agri_service_providers'].forEach((v) {
        _matchingAgriServiceProviders
            ?.add(MatchingAgriServiceProviders.fromJson(v));
      });
    }
    _count = json['count'];
  }
  List<MatchingAgriServiceProviders>? _matchingAgriServiceProviders;
  num? _count;
  Result copyWith({
    List<MatchingAgriServiceProviders>? matchingAgriServiceProviders,
    num? count,
  }) =>
      Result(
        matchingAgriServiceProviders:
            matchingAgriServiceProviders ?? _matchingAgriServiceProviders,
        count: count ?? _count,
      );
  List<MatchingAgriServiceProviders>? get matchingAgriServiceProviders =>
      _matchingAgriServiceProviders;
  num? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_matchingAgriServiceProviders != null) {
      map['matching_agri_service_providers'] =
          _matchingAgriServiceProviders?.map((v) => v.toJson()).toList();
    }
    map['count'] = _count;
    return map;
  }
}

/// id : 6
/// user_id : 2
/// user_type : "Agri Service Provider"
/// full_name : "Yash Sharma"
/// lives_in : "Pandri, Raipur, Chhattisgarh"
/// roles : [{"id":1,"name":"Broker"},{"id":3,"name":"Lender"},{"id":4,"name":"Investor"},{"id":6,"name":"Property Officer"},{"id":9,"name":"Food Processors"}]
/// image : "http://139.5.189.24:8000/media/user_image/photo_AEZjpNZ.jpg"
/// enquiry_id : null

MatchingAgriServiceProviders matchingAgriServiceProvidersFromJson(String str) =>
    MatchingAgriServiceProviders.fromJson(json.decode(str));
String matchingAgriServiceProvidersToJson(MatchingAgriServiceProviders data) =>
    json.encode(data.toJson());

class MatchingAgriServiceProviders {
  MatchingAgriServiceProviders({
    num? id,
    num? userId,
    String? userType,
    String? fullName,
    String? livesIn,
    List<Roles>? roles,
    String? image,
    dynamic enquiryId,
  }) {
    _id = id;
    _userId = userId;
    _userType = userType;
    _fullName = fullName;
    _livesIn = livesIn;
    _roles = roles;
    _image = image;
    _enquiryId = enquiryId;
  }

  MatchingAgriServiceProviders.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _userType = json['user_type'];
    _fullName = json['full_name'];
    _livesIn = json['lives_in'];
    if (json['services'] != null) {
      _roles = [];
      json['services'].forEach((v) {
        _roles?.add(Roles.fromJson(v));
      });
    }
    _image = json['image'];
    _enquiryId = json['enquiry_id'];
  }
  num? _id;
  num? _userId;
  String? _userType;
  String? _fullName;
  String? _livesIn;
  List<Roles>? _roles;
  String? _image;
  dynamic _enquiryId;
  MatchingAgriServiceProviders copyWith({
    num? id,
    num? userId,
    String? userType,
    String? fullName,
    String? livesIn,
    List<Roles>? roles,
    String? image,
    dynamic enquiryId,
  }) =>
      MatchingAgriServiceProviders(
        id: id ?? _id,
        userId: userId ?? _userId,
        userType: userType ?? _userType,
        fullName: fullName ?? _fullName,
        livesIn: livesIn ?? _livesIn,
        roles: roles ?? _roles,
        image: image ?? _image,
        enquiryId: enquiryId ?? _enquiryId,
      );
  num? get id => _id;
  num? get userId => _userId;
  String? get userType => _userType;
  String? get fullName => _fullName;
  String? get livesIn => _livesIn;
  List<Roles>? get roles => _roles;
  String? get image => _image;
  dynamic get enquiryId => _enquiryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['user_type'] = _userType;
    map['full_name'] = _fullName;
    map['lives_in'] = _livesIn;
    if (_roles != null) {
      map['services'] = _roles?.map((v) => v.toJson()).toList();
    }
    map['image'] = _image;
    map['enquiry_id'] = _enquiryId;
    return map;
  }
}

/// id : 1
/// name : "Broker"

Roles rolesFromJson(String str) => Roles.fromJson(json.decode(str));
String rolesToJson(Roles data) => json.encode(data.toJson());

class Roles {
  Roles({
    num? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  Roles.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
  Roles copyWith({
    num? id,
    String? name,
  }) =>
      Roles(
        id: id ?? _id,
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
