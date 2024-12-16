import 'dart:convert';
/// detail : "Operation Successful"
/// result : {"matching_farmer_list":[{"id":14,"user_id":41,"user_type":"Farmer","full_name":"asd","lives_in":"Raipur","expertise":[{"id":1,"name":"Farming"},{"id":3,"name":"Irrigation"}],"image":"http://139.5.189.24:8000/media/user_image/photo_xP7nRdC.jpg","enquiry_id":null},{"id":15,"user_id":42,"user_type":"Farmer","full_name":"Aman","lives_in":"Raipur","expertise":[{"id":2,"name":"Planting"},{"id":3,"name":"Irrigation"}],"image":"http://139.5.189.24:8000/media/user_image/photo_CKA55pP.jpg","enquiry_id":null},{"id":16,"user_id":45,"user_type":"Farmer","full_name":"Yash Sharma","lives_in":"Mahasamund","expertise":[{"id":1,"name":"Farming"}],"image":"http://139.5.189.24:8000/media/user_image/photo_bHowGu5.jpg","enquiry_id":null},{"id":17,"user_id":46,"user_type":"Farmer","full_name":"Aman tiwari","lives_in":"Raipur","expertise":[{"id":3,"name":"Irrigation"}],"image":"http://139.5.189.24:8000/media/user_image/photo_64FjkHc.jpg","enquiry_id":null},{"id":18,"user_id":49,"user_type":"Farmer","full_name":"asdfgn","lives_in":"Raipur","expertise":[{"id":3,"name":"Irrigation"}],"image":"http://139.5.189.24:8000/media/user_image/photo_A6n6znJ.jpg","enquiry_id":null}],"count":5}

MatchingFarmerResponseModel matchingFarmerResponseModelFromJson(String str) => MatchingFarmerResponseModel.fromJson(json.decode(str));
String matchingFarmerResponseModelToJson(MatchingFarmerResponseModel data) => json.encode(data.toJson());
class MatchingFarmerResponseModel {
  MatchingFarmerResponseModel({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  MatchingFarmerResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
MatchingFarmerResponseModel copyWith({  String? detail,
  Result? result,
}) => MatchingFarmerResponseModel(  detail: detail ?? _detail,
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

/// matching_farmer_list : [{"id":14,"user_id":41,"user_type":"Farmer","full_name":"asd","lives_in":"Raipur","expertise":[{"id":1,"name":"Farming"},{"id":3,"name":"Irrigation"}],"image":"http://139.5.189.24:8000/media/user_image/photo_xP7nRdC.jpg","enquiry_id":null},{"id":15,"user_id":42,"user_type":"Farmer","full_name":"Aman","lives_in":"Raipur","expertise":[{"id":2,"name":"Planting"},{"id":3,"name":"Irrigation"}],"image":"http://139.5.189.24:8000/media/user_image/photo_CKA55pP.jpg","enquiry_id":null},{"id":16,"user_id":45,"user_type":"Farmer","full_name":"Yash Sharma","lives_in":"Mahasamund","expertise":[{"id":1,"name":"Farming"}],"image":"http://139.5.189.24:8000/media/user_image/photo_bHowGu5.jpg","enquiry_id":null},{"id":17,"user_id":46,"user_type":"Farmer","full_name":"Aman tiwari","lives_in":"Raipur","expertise":[{"id":3,"name":"Irrigation"}],"image":"http://139.5.189.24:8000/media/user_image/photo_64FjkHc.jpg","enquiry_id":null},{"id":18,"user_id":49,"user_type":"Farmer","full_name":"asdfgn","lives_in":"Raipur","expertise":[{"id":3,"name":"Irrigation"}],"image":"http://139.5.189.24:8000/media/user_image/photo_A6n6znJ.jpg","enquiry_id":null}]
/// count : 5

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      List<MatchingFarmerList>? matchingFarmerList, 
      num? count,}){
    _matchingFarmerList = matchingFarmerList;
    _count = count;
}

  Result.fromJson(dynamic json) {
    if (json['matching_farmer_list'] != null) {
      _matchingFarmerList = [];
      json['matching_farmer_list'].forEach((v) {
        _matchingFarmerList?.add(MatchingFarmerList.fromJson(v));
      });
    }
    _count = json['count'];
  }
  List<MatchingFarmerList>? _matchingFarmerList;
  num? _count;
Result copyWith({  List<MatchingFarmerList>? matchingFarmerList,
  num? count,
}) => Result(  matchingFarmerList: matchingFarmerList ?? _matchingFarmerList,
  count: count ?? _count,
);
  List<MatchingFarmerList>? get matchingFarmerList => _matchingFarmerList;
  num? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_matchingFarmerList != null) {
      map['matching_farmer_list'] = _matchingFarmerList?.map((v) => v.toJson()).toList();
    }
    map['count'] = _count;
    return map;
  }

}

/// id : 14
/// user_id : 41
/// user_type : "Farmer"
/// full_name : "asd"
/// lives_in : "Raipur"
/// expertise : [{"id":1,"name":"Farming"},{"id":3,"name":"Irrigation"}]
/// image : "http://139.5.189.24:8000/media/user_image/photo_xP7nRdC.jpg"
/// enquiry_id : null

MatchingFarmerList matchingFarmerListFromJson(String str) => MatchingFarmerList.fromJson(json.decode(str));
String matchingFarmerListToJson(MatchingFarmerList data) => json.encode(data.toJson());
class MatchingFarmerList {
  MatchingFarmerList({
      num? id, 
      num? userId, 
      String? userType, 
      String? fullName, 
      String? livesIn, 
      List<Expertise>? expertise, 
      String? image, 
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

  MatchingFarmerList.fromJson(dynamic json) {
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
  String? _image;
  dynamic _enquiryId;
MatchingFarmerList copyWith({  num? id,
  num? userId,
  String? userType,
  String? fullName,
  String? livesIn,
  List<Expertise>? expertise,
  String? image,
  dynamic enquiryId,
}) => MatchingFarmerList(  id: id ?? _id,
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
  String? get image => _image;
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