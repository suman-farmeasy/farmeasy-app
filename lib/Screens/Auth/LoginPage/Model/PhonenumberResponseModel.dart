import 'dart:convert';
/// detail : "Operation Successful"
/// result : "Otp sent seccessful"

PhonenumberResponseModel phonenumberResponseModelFromJson(String str) => PhonenumberResponseModel.fromJson(json.decode(str));
String phonenumberResponseModelToJson(PhonenumberResponseModel data) => json.encode(data.toJson());
class PhonenumberResponseModel {
  PhonenumberResponseModel({
      String? detail, 
      String? result,}){
    _detail = detail;
    _result = result;
}

  PhonenumberResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'];
  }
  String? _detail;
  String? _result;
PhonenumberResponseModel copyWith({  String? detail,
  String? result,
}) => PhonenumberResponseModel(  detail: detail ?? _detail,
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