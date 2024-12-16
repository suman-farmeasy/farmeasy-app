import 'dart:convert';
/// detail : "Operation Successful"
/// result : ""

LandImageResponseModel landImageResponseModelFromJson(String str) => LandImageResponseModel.fromJson(json.decode(str));
String landImageResponseModelToJson(LandImageResponseModel data) => json.encode(data.toJson());
class LandImageResponseModel {
  LandImageResponseModel({
      String? detail, 
      String? result,}){
    _detail = detail;
    _result = result;
}

  LandImageResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'];
  }
  String? _detail;
  String? _result;
LandImageResponseModel copyWith({  String? detail,
  String? result,
}) => LandImageResponseModel(  detail: detail ?? _detail,
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