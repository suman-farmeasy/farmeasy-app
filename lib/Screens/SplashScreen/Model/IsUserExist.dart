import 'dart:convert';
/// detail : "Operation Successful"
/// result : {"is_user_type":true,"is_profile":true,"user_type":"Farmer","name":"Yash Sharma"}

IsUserExist isUserExistFromJson(String str) => IsUserExist.fromJson(json.decode(str));
String isUserExistToJson(IsUserExist data) => json.encode(data.toJson());
class IsUserExist {
  IsUserExist({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  IsUserExist.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
IsUserExist copyWith({  String? detail,
  Result? result,
}) => IsUserExist(  detail: detail ?? _detail,
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

/// is_user_type : true
/// is_profile : true
/// user_type : "Farmer"
/// name : "Yash Sharma"

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      bool? isUserType, 
      bool? isProfile, 
      String? userType, 
      String? name,}){
    _isUserType = isUserType;
    _isProfile = isProfile;
    _userType = userType;
    _name = name;
}

  Result.fromJson(dynamic json) {
    _isUserType = json['is_user_type'];
    _isProfile = json['is_profile'];
    _userType = json['user_type'];
    _name = json['name'];
  }
  bool? _isUserType;
  bool? _isProfile;
  String? _userType;
  String? _name;
Result copyWith({  bool? isUserType,
  bool? isProfile,
  String? userType,
  String? name,
}) => Result(  isUserType: isUserType ?? _isUserType,
  isProfile: isProfile ?? _isProfile,
  userType: userType ?? _userType,
  name: name ?? _name,
);
  bool? get isUserType => _isUserType;
  bool? get isProfile => _isProfile;
  String? get userType => _userType;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_user_type'] = _isUserType;
    map['is_profile'] = _isProfile;
    map['user_type'] = _userType;
    map['name'] = _name;
    return map;
  }

}