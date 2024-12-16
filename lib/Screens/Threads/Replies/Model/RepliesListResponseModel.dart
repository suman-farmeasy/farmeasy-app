import 'dart:convert';
/// detail : "Operation Successful"
/// result : {"data":[{"id":1,"user_id":40,"user_type":"Farmer","user_name":"Yash Sharma","user_image":"http://139.5.189.24:8000/media/user_image/photo_VheRhUD.jpg","reply":"fxghsvsddqdbiwhdiuwqdhuqhd","created_on":"22 February 2024"},{"id":2,"user_id":43,"user_type":"Agri Service Provider","user_name":"Aman","user_image":"http://139.5.189.24:8000/media/user_image/photo_BkmErcZ.jpg","reply":"mANSKJBDJK CDN","created_on":"22 February 2024"}],"page_info":{"total_page":1,"total_object":2,"current_page":1}}

RepliesListResponseModel repliesListResponseModelFromJson(String str) => RepliesListResponseModel.fromJson(json.decode(str));
String repliesListResponseModelToJson(RepliesListResponseModel data) => json.encode(data.toJson());
class RepliesListResponseModel {
  RepliesListResponseModel({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  RepliesListResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
RepliesListResponseModel copyWith({  String? detail,
  Result? result,
}) => RepliesListResponseModel(  detail: detail ?? _detail,
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

/// data : [{"id":1,"user_id":40,"user_type":"Farmer","user_name":"Yash Sharma","user_image":"http://139.5.189.24:8000/media/user_image/photo_VheRhUD.jpg","reply":"fxghsvsddqdbiwhdiuwqdhuqhd","created_on":"22 February 2024"},{"id":2,"user_id":43,"user_type":"Agri Service Provider","user_name":"Aman","user_image":"http://139.5.189.24:8000/media/user_image/photo_BkmErcZ.jpg","reply":"mANSKJBDJK CDN","created_on":"22 February 2024"}]
/// page_info : {"total_page":1,"total_object":2,"current_page":1}

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      List<Data>? data, 
      PageInfo? pageInfo,}){
    _data = data;
    _pageInfo = pageInfo;
}

  Result.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _pageInfo = json['page_info'] != null ? PageInfo.fromJson(json['page_info']) : null;
  }
  List<Data>? _data;
  PageInfo? _pageInfo;
Result copyWith({  List<Data>? data,
  PageInfo? pageInfo,
}) => Result(  data: data ?? _data,
  pageInfo: pageInfo ?? _pageInfo,
);
  List<Data>? get data => _data;
  PageInfo? get pageInfo => _pageInfo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_pageInfo != null) {
      map['page_info'] = _pageInfo?.toJson();
    }
    return map;
  }

}

/// total_page : 1
/// total_object : 2
/// current_page : 1

PageInfo pageInfoFromJson(String str) => PageInfo.fromJson(json.decode(str));
String pageInfoToJson(PageInfo data) => json.encode(data.toJson());
class PageInfo {
  PageInfo({
      num? totalPage, 
      num? totalObject, 
      num? currentPage,}){
    _totalPage = totalPage;
    _totalObject = totalObject;
    _currentPage = currentPage;
}

  PageInfo.fromJson(dynamic json) {
    _totalPage = json['total_page'];
    _totalObject = json['total_object'];
    _currentPage = json['current_page'];
  }
  num? _totalPage;
  num? _totalObject;
  num? _currentPage;
PageInfo copyWith({  num? totalPage,
  num? totalObject,
  num? currentPage,
}) => PageInfo(  totalPage: totalPage ?? _totalPage,
  totalObject: totalObject ?? _totalObject,
  currentPage: currentPage ?? _currentPage,
);
  num? get totalPage => _totalPage;
  num? get totalObject => _totalObject;
  num? get currentPage => _currentPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_page'] = _totalPage;
    map['total_object'] = _totalObject;
    map['current_page'] = _currentPage;
    return map;
  }

}

/// id : 1
/// user_id : 40
/// user_type : "Farmer"
/// user_name : "Yash Sharma"
/// user_image : "http://139.5.189.24:8000/media/user_image/photo_VheRhUD.jpg"
/// reply : "fxghsvsddqdbiwhdiuwqdhuqhd"
/// created_on : "22 February 2024"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      num? userId, 
      String? userType, 
      String? userName, 
      String? userImage, 
      String? reply, 
      String? createdOn,}){
    _id = id;
    _userId = userId;
    _userType = userType;
    _userName = userName;
    _userImage = userImage;
    _reply = reply;
    _createdOn = createdOn;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _userType = json['user_type'];
    _userName = json['user_name'];
    _userImage = json['user_image'];
    _reply = json['reply'];
    _createdOn = json['created_on'];
  }
  num? _id;
  num? _userId;
  String? _userType;
  String? _userName;
  String? _userImage;
  String? _reply;
  String? _createdOn;
Data copyWith({  num? id,
  num? userId,
  String? userType,
  String? userName,
  String? userImage,
  String? reply,
  String? createdOn,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  userType: userType ?? _userType,
  userName: userName ?? _userName,
  userImage: userImage ?? _userImage,
  reply: reply ?? _reply,
  createdOn: createdOn ?? _createdOn,
);
  num? get id => _id;
  num? get userId => _userId;
  String? get userType => _userType;
  String? get userName => _userName;
  String? get userImage => _userImage;
  String? get reply => _reply;
  String? get createdOn => _createdOn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['user_type'] = _userType;
    map['user_name'] = _userName;
    map['user_image'] = _userImage;
    map['reply'] = _reply;
    map['created_on'] = _createdOn;
    return map;
  }

}