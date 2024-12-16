import 'dart:convert';
/// detail : "Operation Successful"
/// result : {"is_liked":true}

LikeUnilkeResponseModel likeUnilkeResponseModelFromJson(String str) => LikeUnilkeResponseModel.fromJson(json.decode(str));
String likeUnilkeResponseModelToJson(LikeUnilkeResponseModel data) => json.encode(data.toJson());
class LikeUnilkeResponseModel {
  LikeUnilkeResponseModel({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  LikeUnilkeResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
LikeUnilkeResponseModel copyWith({  String? detail,
  Result? result,
}) => LikeUnilkeResponseModel(  detail: detail ?? _detail,
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

/// is_liked : true

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      bool? isLiked,}){
    _isLiked = isLiked;
}

  Result.fromJson(dynamic json) {
    _isLiked = json['is_liked'];
  }
  bool? _isLiked;
Result copyWith({  bool? isLiked,
}) => Result(  isLiked: isLiked ?? _isLiked,
);
  bool? get isLiked => _isLiked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_liked'] = _isLiked;
    return map;
  }

}