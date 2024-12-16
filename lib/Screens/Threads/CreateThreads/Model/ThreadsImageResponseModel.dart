import 'dart:convert';
/// detail : "Operation Successful"
/// result : {"id":7}

ThreadsImageResponseModel threadsImageResponseModelFromJson(String str) => ThreadsImageResponseModel.fromJson(json.decode(str));
String threadsImageResponseModelToJson(ThreadsImageResponseModel data) => json.encode(data.toJson());
class ThreadsImageResponseModel {
  ThreadsImageResponseModel({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  ThreadsImageResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
ThreadsImageResponseModel copyWith({  String? detail,
  Result? result,
}) => ThreadsImageResponseModel(  detail: detail ?? _detail,
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

/// id : 7

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      num? id,}){
    _id = id;
}

  Result.fromJson(dynamic json) {
    _id = json['id'];
  }
  num? _id;
Result copyWith({  num? id,
}) => Result(  id: id ?? _id,
);
  num? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    return map;
  }

}