import 'dart:convert';
/// detail : "Operation Successful"
/// result : [{"id":22,"name":"Cotton"},{"id":17,"name":"Soybean"},{"id":34,"name":"Pigeon pea"},{"id":2,"name":"Wheat"},{"id":3,"name":"Rice"},{"id":1,"name":"Maize"},{"id":18,"name":"Turmeric"},{"id":33,"name":"Chili"},{"id":23,"name":"Groundnut"},{"id":21,"name":"Sugarcane"},{"id":24,"name":"Sunflower"},{"id":35,"name":"Gram"},{"id":14,"name":"Mango"},{"id":36,"name":"Guava"},{"id":37,"name":"Banana"}]

ChatGptCropSuggestionResponseModel chatGptCropSuggestionResponseModelFromJson(String str) => ChatGptCropSuggestionResponseModel.fromJson(json.decode(str));
String chatGptCropSuggestionResponseModelToJson(ChatGptCropSuggestionResponseModel data) => json.encode(data.toJson());
class ChatGptCropSuggestionResponseModel {
  ChatGptCropSuggestionResponseModel({
      String? detail, 
      List<Result>? result,}){
    _detail = detail;
    _result = result;
}

  ChatGptCropSuggestionResponseModel.fromJson(dynamic json) {
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
ChatGptCropSuggestionResponseModel copyWith({  String? detail,
  List<Result>? result,
}) => ChatGptCropSuggestionResponseModel(  detail: detail ?? _detail,
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

/// id : 22
/// name : "Cotton"

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Result.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
Result copyWith({  num? id,
  String? name,
}) => Result(  id: id ?? _id,
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