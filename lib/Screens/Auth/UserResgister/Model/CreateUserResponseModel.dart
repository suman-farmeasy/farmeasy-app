import 'dart:convert';
/// detail : "Operation Successful"
/// result : ""

CreateUserResponseModel createUserResponseModelFromJson(String str) => CreateUserResponseModel.fromJson(json.decode(str));
String createUserResponseModelToJson(CreateUserResponseModel data) => json.encode(data.toJson());
class CreateUserResponseModel {
  CreateUserResponseModel({
      String? detail, 
      String? result,}){
    _detail = detail;
    _result = result;
}

  CreateUserResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'];
  }
  String? _detail;
  String? _result;
CreateUserResponseModel copyWith({  String? detail,
  String? result,
}) => CreateUserResponseModel(  detail: detail ?? _detail,
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