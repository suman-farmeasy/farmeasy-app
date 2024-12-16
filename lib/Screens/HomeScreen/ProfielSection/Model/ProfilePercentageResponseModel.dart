import 'dart:convert';
/// detail : "Operation Successful"
/// result : {"completion_percentage":80}

ProfilePercentageResponseModel profilePercentageResponseModelFromJson(String str) => ProfilePercentageResponseModel.fromJson(json.decode(str));
String profilePercentageResponseModelToJson(ProfilePercentageResponseModel data) => json.encode(data.toJson());
class ProfilePercentageResponseModel {
  ProfilePercentageResponseModel({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  ProfilePercentageResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
ProfilePercentageResponseModel copyWith({  String? detail,
  Result? result,
}) => ProfilePercentageResponseModel(  detail: detail ?? _detail,
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

/// completion_percentage : 80

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      num? completionPercentage,}){
    _completionPercentage = completionPercentage;
}

  Result.fromJson(dynamic json) {
    _completionPercentage = json['completion_percentage'];
  }
  num? _completionPercentage;
Result copyWith({  num? completionPercentage,
}) => Result(  completionPercentage: completionPercentage ?? _completionPercentage,
);
  num? get completionPercentage => _completionPercentage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['completion_percentage'] = _completionPercentage;
    return map;
  }

}