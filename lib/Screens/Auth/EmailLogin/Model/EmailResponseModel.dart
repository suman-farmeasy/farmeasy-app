import 'dart:convert';
/// detail : "Operation Successful"
/// result : "Otp sent seccessful"

EmailResponseModel emailResponseModelFromJson(String str) => EmailResponseModel.fromJson(json.decode(str));
String emailResponseModelToJson(EmailResponseModel data) => json.encode(data.toJson());
class EmailResponseModel {
  EmailResponseModel({
      String? detail, 
      String? result,}){
    _detail = detail;
    _result = result;
}

  EmailResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'];
  }
  String? _detail;
  String? _result;
EmailResponseModel copyWith({  String? detail,
  String? result,
}) => EmailResponseModel(  detail: detail ?? _detail,
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