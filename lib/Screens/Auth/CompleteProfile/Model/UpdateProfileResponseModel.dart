import 'dart:convert';
/// detail : "Operation Successful"
/// result : ""

UpdateProfileResponseModel updateProfileResponseModelFromJson(String str) => UpdateProfileResponseModel.fromJson(json.decode(str));
String updateProfileResponseModelToJson(UpdateProfileResponseModel data) => json.encode(data.toJson());
class UpdateProfileResponseModel {
  UpdateProfileResponseModel({
      String? detail, 
      String? result,}){
    _detail = detail;
    _result = result;
}

  UpdateProfileResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'];
  }
  String? _detail;
  String? _result;
UpdateProfileResponseModel copyWith({  String? detail,
  String? result,
}) => UpdateProfileResponseModel(  detail: detail ?? _detail,
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