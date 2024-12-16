import 'dart:convert';

/// detail : "Operation Successful"
/// result : {"data":[{"id":6,"user_id":2,"user_type":"Agri Service Provider","full_name":"Yash Sharma","lives_in":"Pandri, Raipur, Chhattisgarh","roles":[{"id":1,"name":"Broker"},{"id":3,"name":"Lender"},{"id":4,"name":"Investor"},{"id":6,"name":"Property Officer"},{"id":9,"name":"Food Processors"}],"image":"http://139.5.189.24:8000/media/user_image/photo_AEZjpNZ.jpg","enquiry_id":32},{"id":8,"user_id":1,"user_type":"Farmer","full_name":"Aman","lives_in":"Raipur","roles":[{"id":2,"name":"Lawyer"},{"id":4,"name":"Investor"}],"image":"http://139.5.189.24:8000/media/user_image/photo_spE3lmH.jpg","enquiry_id":null},{"id":9,"user_id":43,"user_type":"Agri Service Provider","full_name":"Aman","lives_in":"Raipur","roles":[{"id":4,"name":"Investor"}],"image":"http://139.5.189.24:8000/media/user_image/photo_BkmErcZ.jpg","enquiry_id":null},{"id":10,"user_id":44,"user_type":"Agri Service Provider","full_name":"Yash Sharma","lives_in":"Raipur","roles":[{"id":3,"name":"Lender"},{"id":4,"name":"Investor"}],"image":"http://139.5.189.24:8000/media/user_image/photo_dN7SLCu.jpg","enquiry_id":null},{"id":11,"user_id":47,"user_type":"Agri Service Provider","full_name":"Aman tiwari","lives_in":"Mahasamund","roles":[{"id":1,"name":"Broker"},{"id":3,"name":"Lender"},{"id":6,"name":"Property Officer"}],"image":"http://139.5.189.24:8000/media/user_image/photo_mK0z18h.jpg","enquiry_id":null},{"id":12,"user_id":48,"user_type":"Agri Service Provider","full_name":"asd","lives_in":"Raipur","roles":[{"id":1,"name":"Broker"},{"id":3,"name":"Lender"},{"id":6,"name":"Property Officer"}],"image":"http://139.5.189.24:8000/media/user_image/photo_I22w78h.jpg","enquiry_id":null},{"id":13,"user_id":50,"user_type":"Agri Service Provider","full_name":"Yash Sharma","lives_in":"Raipur","roles":[{"id":3,"name":"Lender"},{"id":6,"name":"Property Officer"}],"image":"http://139.5.189.24:8000/media/user_image/photo_HVy8w7a.jpg","enquiry_id":null},{"id":14,"user_id":76,"user_type":"Land Owner","full_name":"ABC","lives_in":"Raipur","roles":[{"id":5,"name":"Soil Testing"},{"id":7,"name":"Food Retailer"}],"image":"http://139.5.189.24:8000/media/user_image/photo_13J6Pt0.jpg","enquiry_id":null},{"id":15,"user_id":49,"user_type":"Farmer","full_name":"Ravi","lives_in":"Mahasamund","roles":[{"id":4,"name":"Investor"},{"id":6,"name":"Property Officer"}],"image":null,"enquiry_id":null},{"id":16,"user_id":53,"user_type":"Land Owner","full_name":"Yash Sharma","lives_in":"Raipur","roles":[{"id":2,"name":"Lawyer"}],"image":"http://139.5.189.24:8000/media/user_image/photo_02Y3kjs.jpg","enquiry_id":null}],"page_info":{"total_page":2,"total_object":11,"current_page":1}}

ListAgriProviderResponseModel listAgriProviderResponseModelFromJson(
        String str) =>
    ListAgriProviderResponseModel.fromJson(json.decode(str));
String listAgriProviderResponseModelToJson(
        ListAgriProviderResponseModel data) =>
    json.encode(data.toJson());

class ListAgriProviderResponseModel {
  ListAgriProviderResponseModel({
    String? detail,
    Result? result,
  }) {
    _detail = detail;
    _result = result;
  }

  ListAgriProviderResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
  ListAgriProviderResponseModel copyWith({
    String? detail,
    Result? result,
  }) =>
      ListAgriProviderResponseModel(
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

/// data : [{"id":6,"user_id":2,"user_type":"Agri Service Provider","full_name":"Yash Sharma","lives_in":"Pandri, Raipur, Chhattisgarh","roles":[{"id":1,"name":"Broker"},{"id":3,"name":"Lender"},{"id":4,"name":"Investor"},{"id":6,"name":"Property Officer"},{"id":9,"name":"Food Processors"}],"image":"http://139.5.189.24:8000/media/user_image/photo_AEZjpNZ.jpg","enquiry_id":32},{"id":8,"user_id":1,"user_type":"Farmer","full_name":"Aman","lives_in":"Raipur","roles":[{"id":2,"name":"Lawyer"},{"id":4,"name":"Investor"}],"image":"http://139.5.189.24:8000/media/user_image/photo_spE3lmH.jpg","enquiry_id":null},{"id":9,"user_id":43,"user_type":"Agri Service Provider","full_name":"Aman","lives_in":"Raipur","roles":[{"id":4,"name":"Investor"}],"image":"http://139.5.189.24:8000/media/user_image/photo_BkmErcZ.jpg","enquiry_id":null},{"id":10,"user_id":44,"user_type":"Agri Service Provider","full_name":"Yash Sharma","lives_in":"Raipur","roles":[{"id":3,"name":"Lender"},{"id":4,"name":"Investor"}],"image":"http://139.5.189.24:8000/media/user_image/photo_dN7SLCu.jpg","enquiry_id":null},{"id":11,"user_id":47,"user_type":"Agri Service Provider","full_name":"Aman tiwari","lives_in":"Mahasamund","roles":[{"id":1,"name":"Broker"},{"id":3,"name":"Lender"},{"id":6,"name":"Property Officer"}],"image":"http://139.5.189.24:8000/media/user_image/photo_mK0z18h.jpg","enquiry_id":null},{"id":12,"user_id":48,"user_type":"Agri Service Provider","full_name":"asd","lives_in":"Raipur","roles":[{"id":1,"name":"Broker"},{"id":3,"name":"Lender"},{"id":6,"name":"Property Officer"}],"image":"http://139.5.189.24:8000/media/user_image/photo_I22w78h.jpg","enquiry_id":null},{"id":13,"user_id":50,"user_type":"Agri Service Provider","full_name":"Yash Sharma","lives_in":"Raipur","roles":[{"id":3,"name":"Lender"},{"id":6,"name":"Property Officer"}],"image":"http://139.5.189.24:8000/media/user_image/photo_HVy8w7a.jpg","enquiry_id":null},{"id":14,"user_id":76,"user_type":"Land Owner","full_name":"ABC","lives_in":"Raipur","roles":[{"id":5,"name":"Soil Testing"},{"id":7,"name":"Food Retailer"}],"image":"http://139.5.189.24:8000/media/user_image/photo_13J6Pt0.jpg","enquiry_id":null},{"id":15,"user_id":49,"user_type":"Farmer","full_name":"Ravi","lives_in":"Mahasamund","roles":[{"id":4,"name":"Investor"},{"id":6,"name":"Property Officer"}],"image":null,"enquiry_id":null},{"id":16,"user_id":53,"user_type":"Land Owner","full_name":"Yash Sharma","lives_in":"Raipur","roles":[{"id":2,"name":"Lawyer"}],"image":"http://139.5.189.24:8000/media/user_image/photo_02Y3kjs.jpg","enquiry_id":null}]
/// page_info : {"total_page":2,"total_object":11,"current_page":1}

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());

class Result {
  Result({
    List<Data>? data,
    PageInfo? pageInfo,
  }) {
    _data = data;
    _pageInfo = pageInfo;
  }

  Result.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _pageInfo =
        json['page_info'] != null ? PageInfo.fromJson(json['page_info']) : null;
  }
  List<Data>? _data;
  PageInfo? _pageInfo;
  Result copyWith({
    List<Data>? data,
    PageInfo? pageInfo,
  }) =>
      Result(
        data: data ?? _data,
        pageInfo: pageInfo ?? _pageInfo,
      );
  List<Data>? get data => _data;
  PageInfo? get pageInfo => _pageInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_pageInfo != null) {
      map['page_info'] = _pageInfo?.toJson();
    }
    return map;
  }
}

/// total_page : 2
/// total_object : 11
/// current_page : 1

PageInfo pageInfoFromJson(String str) => PageInfo.fromJson(json.decode(str));
String pageInfoToJson(PageInfo data) => json.encode(data.toJson());

class PageInfo {
  PageInfo({
    num? totalPage,
    num? totalObject,
    num? currentPage,
  }) {
    _totalPage = totalPage;
    _totalObject = totalObject;
    _currentPage = currentPage;
  }

  PageInfo.fromJson(dynamic json) {
    _totalPage = json['total_page'];
    _totalObject = json['total_object'];
    _currentPage = json['current_page'];
  }
  num? _totalPage;
  num? _totalObject;
  num? _currentPage;
  PageInfo copyWith({
    num? totalPage,
    num? totalObject,
    num? currentPage,
  }) =>
      PageInfo(
        totalPage: totalPage ?? _totalPage,
        totalObject: totalObject ?? _totalObject,
        currentPage: currentPage ?? _currentPage,
      );
  num? get totalPage => _totalPage;
  num? get totalObject => _totalObject;
  num? get currentPage => _currentPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_page'] = _totalPage;
    map['total_object'] = _totalObject;
    map['current_page'] = _currentPage;
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
/// enquiry_id : 32

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    int? id,
    int? userId,
    String? userType,
    String? fullName,
    String? livesIn,
    List<Roles>? roles,
    String? image,
    num? enquiryId,
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

  Data.fromJson(dynamic json) {
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
  int? _id;
  int? _userId;
  String? _userType;
  String? _fullName;
  String? _livesIn;
  List<Roles>? _roles;
  String? _image;
  num? _enquiryId;
  Data copyWith({
    int? id,
    int? userId,
    String? userType,
    String? fullName,
    String? livesIn,
    List<Roles>? roles,
    String? image,
    num? enquiryId,
  }) =>
      Data(
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
  num? get enquiryId => _enquiryId;

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
