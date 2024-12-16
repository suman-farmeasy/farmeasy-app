import 'dart:convert';
/// detail : "Operation Successful"
/// result : ""

ReviewResponseMdoel reviewResponseMdoelFromJson(String str) => ReviewResponseMdoel.fromJson(json.decode(str));
String reviewResponseMdoelToJson(ReviewResponseMdoel data) => json.encode(data.toJson());
class ReviewResponseMdoel {
  ReviewResponseMdoel({
      String? detail, 
      String? result,}){
    _detail = detail;
    _result = result;
}

  ReviewResponseMdoel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'];
  }
  String? _detail;
  String? _result;
ReviewResponseMdoel copyWith({  String? detail,
  String? result,
}) => ReviewResponseMdoel(  detail: detail ?? _detail,
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