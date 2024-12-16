import 'dart:convert';

/// detail : "Operation Successful"
/// result : [{"id":1,"name":"Broker"},{"id":2,"name":"Lawyer"},{"id":3,"name":"Lender"},{"id":4,"name":"Investor"}]

AgriProviderResponseModel agriProviderResponseModelFromJson(String str) =>
    AgriProviderResponseModel.fromJson(json.decode(str));
String agriProviderResponseModelToJson(AgriProviderResponseModel data) =>
    json.encode(data.toJson());

class AgriProviderResponseModel {
  AgriProviderResponseModel({
    String? detail,
    List<Result>? result,
  }) {
    _detail = detail;
    _result = result;
  }

  AgriProviderResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
  }
  String? _detail;
  List<Result>? _result;
  AgriProviderResponseModel copyWith({
    String? detail,
    List<Result>? result,
  }) =>
      AgriProviderResponseModel(
        detail: detail ?? _detail,
        result: result ?? _result,
      );
  String? get detail => _detail;
  List<Result>? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['detail'] = _detail;
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// name : "Broker"

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());

class Result {
  Result({
    num? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  Result.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
  Result copyWith({
    num? id,
    String? name,
  }) =>
      Result(
        id: id ?? _id,
        name: name ?? _name,
      );
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}
