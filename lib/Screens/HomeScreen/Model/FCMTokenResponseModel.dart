import 'dart:convert';
/// detail : "FCM token updated"
/// result : ""

FcmTokenResponseModel fcmTokenResponseModelFromJson(String str) => FcmTokenResponseModel.fromJson(json.decode(str));
String fcmTokenResponseModelToJson(FcmTokenResponseModel data) => json.encode(data.toJson());
class FcmTokenResponseModel {
  FcmTokenResponseModel({
      String? detail, 
      String? result,}){
    _detail = detail;
    _result = result;
}

  FcmTokenResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'];
  }
  String? _detail;
  String? _result;
FcmTokenResponseModel copyWith({  String? detail,
  String? result,
}) => FcmTokenResponseModel(  detail: detail ?? _detail,
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