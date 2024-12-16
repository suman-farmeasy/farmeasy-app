import 'dart:convert';
/// detail : "Otp verification successful"
/// result : {"refresh":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTEzNjAxNCwiaWF0IjoxNzA1MDQ5NjE0LCJqdGkiOiI1N2VmN2U3YmJjMTU0NzQ0YTZjYWVmMDJmZTI2N2ZlMSIsInVzZXJfaWQiOjJ9.jUgfd4EHFLl54aDf2otj3stKFwkp3hPl7mj4EQFOCTA","access":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA1MDQ5OTE0LCJpYXQiOjE3MDUwNDk2MTQsImp0aSI6IjNjZTI0YjI5N2Q2NTRlZGM4NGE3NmQ1ODE0NzIzZWJmIiwidXNlcl9pZCI6Mn0.i4OoHmFSgVTxE9sE6F7jWIB5E7KcE0vGKhgH6V6gI9Q"}

PhoneOtpResponseModel phoneOtpResponseModelFromJson(String str) => PhoneOtpResponseModel.fromJson(json.decode(str));
String phoneOtpResponseModelToJson(PhoneOtpResponseModel data) => json.encode(data.toJson());
class PhoneOtpResponseModel {
  PhoneOtpResponseModel({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  PhoneOtpResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
PhoneOtpResponseModel copyWith({  String? detail,
  Result? result,
}) => PhoneOtpResponseModel(  detail: detail ?? _detail,
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

/// refresh : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoicmVmcmVzaCIsImV4cCI6MTcwNTEzNjAxNCwiaWF0IjoxNzA1MDQ5NjE0LCJqdGkiOiI1N2VmN2U3YmJjMTU0NzQ0YTZjYWVmMDJmZTI2N2ZlMSIsInVzZXJfaWQiOjJ9.jUgfd4EHFLl54aDf2otj3stKFwkp3hPl7mj4EQFOCTA"
/// access : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzA1MDQ5OTE0LCJpYXQiOjE3MDUwNDk2MTQsImp0aSI6IjNjZTI0YjI5N2Q2NTRlZGM4NGE3NmQ1ODE0NzIzZWJmIiwidXNlcl9pZCI6Mn0.i4OoHmFSgVTxE9sE6F7jWIB5E7KcE0vGKhgH6V6gI9Q"

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