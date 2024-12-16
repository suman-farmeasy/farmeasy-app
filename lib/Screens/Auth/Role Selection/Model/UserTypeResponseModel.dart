import 'dart:convert';
/// detail : "Operation Successful"
/// result : ""

UserTypeResponseModel userTypeResponseModelFromJson(String str) => UserTypeResponseModel.fromJson(json.decode(str));
String userTypeResponseModelToJson(UserTypeResponseModel data) => json.encode(data.toJson());
class UserTypeResponseModel {
  UserTypeResponseModel({
      String? detail, 
      String? result,}){
    _detail = detail;
    _result = result;
}

  UserTypeResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'];
  }
  String? _detail;
  String? _result;
UserTypeResponseModel copyWith({  String? detail,
  String? result,
}) => UserTypeResponseModel(  detail: detail ?? _detail,
  result: result ?? _result,
);
  String? get detail => _detail;
  String? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['detail'] = _detail;
    map['result'] = _result;
    return map;
  }

}