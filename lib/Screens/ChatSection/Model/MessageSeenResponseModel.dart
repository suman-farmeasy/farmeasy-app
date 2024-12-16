import 'dart:convert';
/// detail : "Operation Successful"
/// result : ""

MessageSeenResponseModel messageSeenResponseModelFromJson(String str) => MessageSeenResponseModel.fromJson(json.decode(str));
String messageSeenResponseModelToJson(MessageSeenResponseModel data) => json.encode(data.toJson());
class MessageSeenResponseModel {
  MessageSeenResponseModel({
      String? detail, 
      String? result,}){
    _detail = detail;
    _result = result;
}

  MessageSeenResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'];
  }
  String? _detail;
  String? _result;
MessageSeenResponseModel copyWith({  String? detail,
  String? result,
}) => MessageSeenResponseModel(  detail: detail ?? _detail,
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