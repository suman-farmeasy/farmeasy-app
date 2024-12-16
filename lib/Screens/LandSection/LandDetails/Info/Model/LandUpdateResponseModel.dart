import 'dart:convert';
/// detail : "Operation Successful"
/// result : ""

LandUpdateResponseModel landUpdateResponseModelFromJson(String str) => LandUpdateResponseModel.fromJson(json.decode(str));
String landUpdateResponseModelToJson(LandUpdateResponseModel data) => json.encode(data.toJson());
class LandUpdateResponseModel {
  LandUpdateResponseModel({
      String? detail, 
      String? result,}){
    _detail = detail;
    _result = result;
}

  LandUpdateResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'];
  }
  String? _detail;
  String? _result;
LandUpdateResponseModel copyWith({  String? detail,
  String? result,
}) => LandUpdateResponseModel(  detail: detail ?? _detail,
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