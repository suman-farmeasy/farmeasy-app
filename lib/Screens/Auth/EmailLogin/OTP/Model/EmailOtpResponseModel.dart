import 'dart:convert';
/// detail : "Otp verification successful"
/// result : {"refresh":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTczNjU5NDg1MiwiaWF0IjoxNzA1MDU4ODUyLCJqdGkiOiJlM2Y4MjgzMTZiZDk0NGFmYjlhNGE0MTNiZmVhZWIxZSIsInVzZXJfaWQiOjR9.nrwnWnT19biAvLypq1GNaC6qkBBItU4-0Z4VyUjsd7M","access":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzM2NTk0ODUyLCJpYXQiOjE3MDUwNTg4NTIsImp0aSI6IjQ0YTk3NjYyNWM0YzQxMTI5NWM2NTNhYzg4NGYzOTAyIiwidXNlcl9pZCI6NH0.rysaRtqKK6naNDJUX-7DLLJcZIodoMQPHws5BTDKRXs"}

EmailOtpResponseModel emailOtpResponseModelFromJson(String str) => EmailOtpResponseModel.fromJson(json.decode(str));
String emailOtpResponseModelToJson(EmailOtpResponseModel data) => json.encode(data.toJson());
class EmailOtpResponseModel {
  EmailOtpResponseModel({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  EmailOtpResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
EmailOtpResponseModel copyWith({  String? detail,
  Result? result,
}) => EmailOtpResponseModel(  detail: detail ?? _detail,
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

/// refresh : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTczNjU5NDg1MiwiaWF0IjoxNzA1MDU4ODUyLCJqdGkiOiJlM2Y4MjgzMTZiZDk0NGFmYjlhNGE0MTNiZmVhZWIxZSIsInVzZXJfaWQiOjR9.nrwnWnT19biAvLypq1GNaC6qkBBItU4-0Z4VyUjsd7M"
/// access : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzM2NTk0ODUyLCJpYXQiOjE3MDUwNTg4NTIsImp0aSI6IjQ0YTk3NjYyNWM0YzQxMTI5NWM2NTNhYzg4NGYzOTAyIiwidXNlcl9pZCI6NH0.rysaRtqKK6naNDJUX-7DLLJcZIodoMQPHws5BTDKRXs"

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      String? refresh, 
      String? access,}){
    _refresh = refresh;
    _access = access;
}

  Result.fromJson(dynamic json) {
    _refresh = json['refresh'];
    _access = json['access'];
  }
  String? _refresh;
  String? _access;
Result copyWith({  String? refresh,
  String? access,
}) => Result(  refresh: refresh ?? _refresh,
  access: access ?? _access,
);
  String? get refresh => _refresh;
  String? get access => _access;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['refresh'] = _refresh;
    map['access'] = _access;
    return map;
  }

}