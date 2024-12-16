import 'dart:convert';
/// detail : "Operation Successful"
/// result : ""

ImageResponseData imageResponseDataFromJson(String str) => ImageResponseData.fromJson(json.decode(str));
String imageResponseDataToJson(ImageResponseData data) => json.encode(data.toJson());
class ImageResponseData {
  ImageResponseData({
      String? detail, 
      String? result,}){
    _detail = detail;
    _result = result;
}

  ImageResponseData.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'];
  }
  String? _detail;
  String? _result;
ImageResponseData copyWith({  String? detail,
  String? result,
}) => ImageResponseData(  detail: detail ?? _detail,
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