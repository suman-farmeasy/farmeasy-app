import 'dart:convert';
/// detail : "Operation Successful"
/// result : ""

ThreadCreatedResponseModel threadCreatedResponseModelFromJson(String str) => ThreadCreatedResponseModel.fromJson(json.decode(str));
String threadCreatedResponseModelToJson(ThreadCreatedResponseModel data) => json.encode(data.toJson());
class ThreadCreatedResponseModel {
  ThreadCreatedResponseModel({
      String? detail, 
      String? result,}){
    _detail = detail;
    _result = result;
}

  ThreadCreatedResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'];
  }
  String? _detail;
  String? _result;
ThreadCreatedResponseModel copyWith({  String? detail,
  String? result,
}) => ThreadCreatedResponseModel(  detail: detail ?? _detail,
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