import 'dart:convert';
/// detail : "Operation Successful"
/// result : {"enquiry_id":4}

SendMessageResponseModel sendMessageResponseModelFromJson(String str) => SendMessageResponseModel.fromJson(json.decode(str));
String sendMessageResponseModelToJson(SendMessageResponseModel data) => json.encode(data.toJson());
class SendMessageResponseModel {
  SendMessageResponseModel({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  SendMessageResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
SendMessageResponseModel copyWith({  String? detail,
  Result? result,
}) => SendMessageResponseModel(  detail: detail ?? _detail,
  result: result ?? _result,
);
  String? get detail => _detail;
  Result? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['detail'] = _detail;
    if (_result != null) {
      map['result'] = _result?.toJson();
    }
    return map;
  }

}

/// enquiry_id : 4

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      num? enquiryId,}){
    _enquiryId = enquiryId;
}

  Result.fromJson(dynamic json) {
    _enquiryId = json['enquiry_id'];
  }
  num? _enquiryId;
Result copyWith({  num? enquiryId,
}) => Result(  enquiryId: enquiryId ?? _enquiryId,
);
  num? get enquiryId => _enquiryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['enquiry_id'] = _enquiryId;
    return map;
  }

}