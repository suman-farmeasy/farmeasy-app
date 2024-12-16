import 'dart:convert';
/// detail : "Operation Successful"
/// result : {"data":[{"id":20,"user_id":55,"user_type":"Farmer","full_name":"sahil","lives_in":"Pandri, Raipur, Chhattisgarh","expertise":[{"id":1,"name":"Farming"},{"id":2,"name":"Planting"},{"id":3,"name":"Irrigation"},{"id":4,"name":"Fencing"},{"id":5,"name":"Harvesting"}],"image":null,"enquiry_id":null},{"id":21,"user_id":74,"user_type":"Farmer","full_name":"shri","lives_in":"Panvel, Navi Mumbai, Maharashtra, India","expertise":[{"id":1,"name":"Farming"},{"id":4,"name":"Fencing"}],"image":null,"enquiry_id":null},{"id":22,"user_id":84,"user_type":"Farmer","full_name":"shrisahil","lives_in":"Pandri, Raipur, Chhattisgarh, India","expertise":[{"id":1,"name":"Farming"},{"id":2,"name":"Planting"},{"id":3,"name":"Irrigation"},{"id":4,"name":"Fencing"},{"id":5,"name":"Harvesting"}],"image":"http://139.5.189.24:8000/media/user_image/image_cropper_1711696866649.jpg","enquiry_id":null},{"id":23,"user_id":92,"user_type":"Farmer","full_name":"Yash verma","lives_in":"Dubai World Trade Centre - Sheikh Zayed Road - Dubai - United Arab Emirates","expertise":[{"id":1,"name":"Farming"},{"id":2,"name":"Planting"}],"image":"http://139.5.189.24:8000/media/user_image/image_cropper_1711776315047.jpg","enquiry_id":null},{"id":24,"user_id":94,"user_type":"Farmer","full_name":"Jose alfonso","lives_in":"Cavite, Philippines","expertise":[{"id":2,"name":"Planting"},{"id":3,"name":"Irrigation"}],"image":"http://139.5.189.24:8000/media/user_image/image_cropper_1711778774047.jpg","enquiry_id":null},{"id":25,"user_id":95,"user_type":"Farmer","full_name":"Rahul","lives_in":"Solan, Himachal Pradesh, India","expertise":[{"id":1,"name":"Farming"},{"id":3,"name":"Irrigation"}],"image":null,"enquiry_id":null},{"id":26,"user_id":96,"user_type":"Farmer","full_name":"Jose Farmer","lives_in":"Cavite City, Cavite, Philippines","expertise":[{"id":1,"name":"Farming"}],"image":"http://139.5.189.24:8000/media/user_image/famer_6.jpg","enquiry_id":null},{"id":27,"user_id":97,"user_type":"Farmer","full_name":"Jose Bautista","lives_in":"Mendez, Cavite, Philippines","expertise":[],"image":"http://139.5.189.24:8000/media/user_image/farmer_1.jpg","enquiry_id":null},{"id":28,"user_id":98,"user_type":"Farmer","full_name":"Sofia Reyes","lives_in":"Quezon City, Metro Manila, Philippines","expertise":[{"id":1,"name":"Farming"}],"image":"http://139.5.189.24:8000/media/user_image/sofia.jpg","enquiry_id":null},{"id":29,"user_id":99,"user_type":"Farmer","full_name":"Rafael Santos","lives_in":"Quezon Avenue, Diliman, Quezon City, Metro Manila, Philippines","expertise":[{"id":1,"name":"Farming"}],"image":"http://139.5.189.24:8000/media/user_image/famer_6_jZ7i6UO.jpg","enquiry_id":null}],"page_info":{"total_page":2,"total_object":11,"current_page":1}}

FarmerListResponseModel farmerListResponseModelFromJson(String str) => FarmerListResponseModel.fromJson(json.decode(str));
String farmerListResponseModelToJson(FarmerListResponseModel data) => json.encode(data.toJson());
class FarmerListResponseModel {
  FarmerListResponseModel({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  FarmerListResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
FarmerListResponseModel copyWith({  String? detail,
  Result? result,
}) => FarmerListResponseModel(  detail: detail ?? _detail,
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

/// data : [{"id":20,"user_id":55,"user_type":"Farmer","full_name":"sahil","lives_in":"Pandri, Raipur, Chhattisgarh","expertise":[{"id":1,"name":"Farming"},{"id":2,"name":"Planting"},{"id":3,"name":"Irrigation"},{"id":4,"name":"Fencing"},{"id":5,"name":"Harvesting"}],"image":null,"enquiry_id":null},{"id":21,"user_id":74,"user_type":"Farmer","full_name":"shri","lives_in":"Panvel, Navi Mumbai, Maharashtra, India","expertise":[{"id":1,"name":"Farming"},{"id":4,"name":"Fencing"}],"image":null,"enquiry_id":null},{"id":22,"user_id":84,"user_type":"Farmer","full_name":"shrisahil","lives_in":"Pandri, Raipur, Chhattisgarh, India","expertise":[{"id":1,"name":"Farming"},{"id":2,"name":"Planting"},{"id":3,"name":"Irrigation"},{"id":4,"name":"Fencing"},{"id":5,"name":"Harvesting"}],"image":"http://139.5.189.24:8000/media/user_image/image_cropper_1711696866649.jpg","enquiry_id":null},{"id":23,"user_id":92,"user_type":"Farmer","full_name":"Yash verma","lives_in":"Dubai World Trade Centre - Sheikh Zayed Road - Dubai - United Arab Emirates","expertise":[{"id":1,"name":"Farming"},{"id":2,"name":"Planting"}],"image":"http://139.5.189.24:8000/media/user_image/image_cropper_1711776315047.jpg","enquiry_id":null},{"id":24,"user_id":94,"user_type":"Farmer","full_name":"Jose alfonso","lives_in":"Cavite, Philippines","expertise":[{"id":2,"name":"Planting"},{"id":3,"name":"Irrigation"}],"image":"http://139.5.189.24:8000/media/user_image/image_cropper_1711778774047.jpg","enquiry_id":null},{"id":25,"user_id":95,"user_type":"Farmer","full_name":"Rahul","lives_in":"Solan, Himachal Pradesh, India","expertise":[{"id":1,"name":"Farming"},{"id":3,"name":"Irrigation"}],"image":null,"enquiry_id":null},{"id":26,"user_id":96,"user_type":"Farmer","full_name":"Jose Farmer","lives_in":"Cavite City, Cavite, Philippines","expertise":[{"id":1,"name":"Farming"}],"image":"http://139.5.189.24:8000/media/user_image/famer_6.jpg","enquiry_id":null},{"id":27,"user_id":97,"user_type":"Farmer","full_name":"Jose Bautista","lives_in":"Mendez, Cavite, Philippines","expertise":[],"image":"http://139.5.189.24:8000/media/user_image/farmer_1.jpg","enquiry_id":null},{"id":28,"user_id":98,"user_type":"Farmer","full_name":"Sofia Reyes","lives_in":"Quezon City, Metro Manila, Philippines","expertise":[{"id":1,"name":"Farming"}],"image":"http://139.5.189.24:8000/media/user_image/sofia.jpg","enquiry_id":null},{"id":29,"user_id":99,"user_type":"Farmer","full_name":"Rafael Santos","lives_in":"Quezon Avenue, Diliman, Quezon City, Metro Manila, Philippines","expertise":[{"id":1,"name":"Farming"}],"image":"http://139.5.189.24:8000/media/user_image/famer_6_jZ7i6UO.jpg","enquiry_id":null}]
/// page_info : {"total_page":2,"total_object":11,"current_page":1}

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      List<Data>? data, 
      PageInfo? pageInfo,}){
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
    _pageInfo = json['page_info'] != null ? PageInfo.fromJson(json['page_info']) : null;
  }
  List<Data>? _data;
  PageInfo? _pageInfo;
Result copyWith({  List<Data>? data,
  PageInfo? pageInfo,
}) => Result(  data: data ?? _data,
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
      num? currentPage,}){
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
PageInfo copyWith({  num? totalPage,
  num? totalObject,
  num? currentPage,
}) => PageInfo(  totalPage: totalPage ?? _totalPage,
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

/// id : 20
/// user_id : 55
/// user_type : "Farmer"
/// full_name : "sahil"
/// lives_in : "Pandri, Raipur, Chhattisgarh"
/// expertise : [{"id":1,"name":"Farming"},{"id":2,"name":"Planting"},{"id":3,"name":"Irrigation"},{"id":4,"name":"Fencing"},{"id":5,"name":"Harvesting"}]
/// image : null
/// enquiry_id : null

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      num? userId, 
      String? userType, 
      String? fullName, 
      String? livesIn, 
      List<Expertise>? expertise, 
      dynamic image, 
      dynamic enquiryId,}){
    _id = id;
    _userId = userId;
    _userType = userType;
    _fullName = fullName;
    _livesIn = livesIn;
    _expertise = expertise;
    _image = image;
    _enquiryId = enquiryId;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _userType = json['user_type'];
    _fullName = json['full_name'];
    _livesIn = json['lives_in'];
    if (json['expertise'] != null) {
      _expertise = [];
      json['expertise'].forEach((v) {
        _expertise?.add(Expertise.fromJson(v));
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
  List<Expertise>? _expertise;
  dynamic _image;
  dynamic _enquiryId;
Data copyWith({  num? id,
  num? userId,
  String? userType,
  String? fullName,
  String? livesIn,
  List<Expertise>? expertise,
  dynamic image,
  dynamic enquiryId,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  userType: userType ?? _userType,
  fullName: fullName ?? _fullName,
  livesIn: livesIn ?? _livesIn,
  expertise: expertise ?? _expertise,
  image: image ?? _image,
  enquiryId: enquiryId ?? _enquiryId,
);
  num? get id => _id;
  num? get userId => _userId;
  String? get userType => _userType;
  String? get fullName => _fullName;
  String? get livesIn => _livesIn;
  List<Expertise>? get expertise => _expertise;
  dynamic get image => _image;
  dynamic get enquiryId => _enquiryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['user_type'] = _userType;
    map['full_name'] = _fullName;
    map['lives_in'] = _livesIn;
    if (_expertise != null) {
      map['expertise'] = _expertise?.map((v) => v.toJson()).toList();
    }
    map['image'] = _image;
    map['enquiry_id'] = _enquiryId;
    return map;
  }

}

/// id : 1
/// name : "Farming"

Expertise expertiseFromJson(String str) => Expertise.fromJson(json.decode(str));
String expertiseToJson(Expertise data) => json.encode(data.toJson());
class Expertise {
  Expertise({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Expertise.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
Expertise copyWith({  num? id,
  String? name,
}) => Expertise(  id: id ?? _id,
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