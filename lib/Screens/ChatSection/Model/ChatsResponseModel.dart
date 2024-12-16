import 'dart:convert';
/// detail : "Operation Successful"
/// result : {"data":[{"id":1,"content":"Hello","media":null,"media_type":null,"is_message_by_me":true,"is_seen":false,"created":"10:24 AM"}],"page_info":{"total_page":1,"total_object":1,"current_page":1}}

ChatsResponseModel chatsResponseModelFromJson(String str) => ChatsResponseModel.fromJson(json.decode(str));
String chatsResponseModelToJson(ChatsResponseModel data) => json.encode(data.toJson());
class ChatsResponseModel {
  ChatsResponseModel({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  ChatsResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
ChatsResponseModel copyWith({  String? detail,
  Result? result,
}) => ChatsResponseModel(  detail: detail ?? _detail,
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

/// data : [{"id":1,"content":"Hello","media":null,"media_type":null,"is_message_by_me":true,"is_seen":false,"created":"10:24 AM"}]
/// page_info : {"total_page":1,"total_object":1,"current_page":1}

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
/// total_object : 1
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
/// content : "Hello"
/// media : null
/// media_type : null
/// is_message_by_me : true
/// is_seen : false
/// created : "10:24 AM"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      String? content, 
      dynamic media, 
      dynamic mediaType, 
      bool? isMessageByMe, 
      bool? isSeen, 
      String? created,}){
    _id = id;
    _content = content;
    _media = media;
    _mediaType = mediaType;
    _isMessageByMe = isMessageByMe;
    _isSeen = isSeen;
    _created = created;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _content = json['content'];
    _media = json['media'];
    _mediaType = json['media_type'];
    _isMessageByMe = json['is_message_by_me'];
    _isSeen = json['is_seen'];
    _created = json['created'];
  }
  num? _id;
  String? _content;
  dynamic _media;
  dynamic _mediaType;
  bool? _isMessageByMe;
  bool? _isSeen;
  String? _created;
Data copyWith({  num? id,
  String? content,
  dynamic media,
  dynamic mediaType,
  bool? isMessageByMe,
  bool? isSeen,
  String? created,
}) => Data(  id: id ?? _id,
  content: content ?? _content,
  media: media ?? _media,
  mediaType: mediaType ?? _mediaType,
  isMessageByMe: isMessageByMe ?? _isMessageByMe,
  isSeen: isSeen ?? _isSeen,
  created: created ?? _created,
);
  num? get id => _id;
  String? get content => _content;
  dynamic get media => _media;
  dynamic get mediaType => _mediaType;
  bool? get isMessageByMe => _isMessageByMe;
  bool? get isSeen => _isSeen;
  String? get created => _created;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['content'] = _content;
    map['media'] = _media;
    map['media_type'] = _mediaType;
    map['is_message_by_me'] = _isMessageByMe;
    map['is_seen'] = _isSeen;
    map['created'] = _created;
    return map;
  }

}