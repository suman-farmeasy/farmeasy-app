import 'dart:convert';
/// detail : "Operation Successful"
/// result : ""

ReplyDataResponseModel replyDataResponseModelFromJson(String str) => ReplyDataResponseModel.fromJson(json.decode(str));
String replyDataResponseModelToJson(ReplyDataResponseModel data) => json.encode(data.toJson());
class ReplyDataResponseModel {
  ReplyDataResponseModel({
      String? detail, 
      String? result,}){
    _detail = detail;
    _result = result;
}

  ReplyDataResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'];
  }
  String? _detail;
  String? _result;
ReplyDataResponseModel copyWith({  String? detail,
  String? result,
}) => ReplyDataResponseModel(  detail: detail ?? _detail,
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