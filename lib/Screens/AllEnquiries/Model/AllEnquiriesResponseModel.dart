import 'dart:convert';
/// detail : "Operation Successful"
/// result : {"data":[{"id":1,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"Yash Sharma","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_pIqzPBg.jpg","connected_person_address":"Pandri, Raipur, Chhattisgarh","connected_person_user_id":1,"connected_person_user_type":"Farmer","last_message":"hi","unseen_message_count":0,"last_message_date":"53 min ago","is_created_by_me":true,"created":"10:24 AM, 23/02/24"},{"id":2,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"Yash Sharma","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_AEZjpNZ.jpg","connected_person_address":"Pandri, Raipur, Chhattisgarh","connected_person_user_id":2,"connected_person_user_type":"Agri Service Provider","last_message":"","unseen_message_count":0,"last_message_date":"","is_created_by_me":true,"created":"11:56 AM, 23/02/24"},{"id":3,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"Yash Sharma","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_VheRhUD.jpg","connected_person_address":"Mahasamund","connected_person_user_id":40,"connected_person_user_type":"Farmer","last_message":"","unseen_message_count":0,"last_message_date":"","is_created_by_me":false,"created":"11:56 AM, 23/02/24"},{"id":4,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"asd","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_xP7nRdC.jpg","connected_person_address":"Raipur","connected_person_user_id":41,"connected_person_user_type":"Farmer","last_message":"","unseen_message_count":0,"last_message_date":"","is_created_by_me":true,"created":"11:56 AM, 23/02/24"},{"id":5,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"Aman","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_CKA55pP.jpg","connected_person_address":"Raipur","connected_person_user_id":42,"connected_person_user_type":"Farmer","last_message":"","unseen_message_count":0,"last_message_date":"","is_created_by_me":true,"created":"11:57 AM, 23/02/24"},{"id":6,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"Aman","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_BkmErcZ.jpg","connected_person_address":"Raipur","connected_person_user_id":43,"connected_person_user_type":"Agri Service Provider","last_message":"","unseen_message_count":0,"last_message_date":"","is_created_by_me":false,"created":"11:57 AM, 23/02/24"},{"id":7,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"Yash Sharma","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_dN7SLCu.jpg","connected_person_address":"Raipur","connected_person_user_id":44,"connected_person_user_type":"Agri Service Provider","last_message":"","unseen_message_count":0,"last_message_date":"","is_created_by_me":true,"created":"11:57 AM, 23/02/24"},{"id":8,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"Yash Sharma","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_bHowGu5.jpg","connected_person_address":"Mahasamund","connected_person_user_id":45,"connected_person_user_type":"Farmer","last_message":"","unseen_message_count":0,"last_message_date":"","is_created_by_me":true,"created":"11:58 AM, 23/02/24"},{"id":9,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"Aman tiwari","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_64FjkHc.jpg","connected_person_address":"Raipur","connected_person_user_id":46,"connected_person_user_type":"Farmer","last_message":"","unseen_message_count":0,"last_message_date":"","is_created_by_me":true,"created":"11:58 AM, 23/02/24"},{"id":10,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"Aman tiwari","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_mK0z18h.jpg","connected_person_address":"Mahasamund","connected_person_user_id":47,"connected_person_user_type":"Agri Service Provider","last_message":"","unseen_message_count":0,"last_message_date":"","is_created_by_me":true,"created":"11:58 AM, 23/02/24"}],"page_info":{"total_page":2,"total_object":12,"current_page":1}}

AllEnquiriesResponseModel allEnquiriesResponseModelFromJson(String str) => AllEnquiriesResponseModel.fromJson(json.decode(str));
String allEnquiriesResponseModelToJson(AllEnquiriesResponseModel data) => json.encode(data.toJson());
class AllEnquiriesResponseModel {
  AllEnquiriesResponseModel({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  AllEnquiriesResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
AllEnquiriesResponseModel copyWith({  String? detail,
  Result? result,
}) => AllEnquiriesResponseModel(  detail: detail ?? _detail,
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

/// data : [{"id":1,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"Yash Sharma","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_pIqzPBg.jpg","connected_person_address":"Pandri, Raipur, Chhattisgarh","connected_person_user_id":1,"connected_person_user_type":"Farmer","last_message":"hi","unseen_message_count":0,"last_message_date":"53 min ago","is_created_by_me":true,"created":"10:24 AM, 23/02/24"},{"id":2,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"Yash Sharma","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_AEZjpNZ.jpg","connected_person_address":"Pandri, Raipur, Chhattisgarh","connected_person_user_id":2,"connected_person_user_type":"Agri Service Provider","last_message":"","unseen_message_count":0,"last_message_date":"","is_created_by_me":true,"created":"11:56 AM, 23/02/24"},{"id":3,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"Yash Sharma","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_VheRhUD.jpg","connected_person_address":"Mahasamund","connected_person_user_id":40,"connected_person_user_type":"Farmer","last_message":"","unseen_message_count":0,"last_message_date":"","is_created_by_me":false,"created":"11:56 AM, 23/02/24"},{"id":4,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"asd","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_xP7nRdC.jpg","connected_person_address":"Raipur","connected_person_user_id":41,"connected_person_user_type":"Farmer","last_message":"","unseen_message_count":0,"last_message_date":"","is_created_by_me":true,"created":"11:56 AM, 23/02/24"},{"id":5,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"Aman","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_CKA55pP.jpg","connected_person_address":"Raipur","connected_person_user_id":42,"connected_person_user_type":"Farmer","last_message":"","unseen_message_count":0,"last_message_date":"","is_created_by_me":true,"created":"11:57 AM, 23/02/24"},{"id":6,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"Aman","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_BkmErcZ.jpg","connected_person_address":"Raipur","connected_person_user_id":43,"connected_person_user_type":"Agri Service Provider","last_message":"","unseen_message_count":0,"last_message_date":"","is_created_by_me":false,"created":"11:57 AM, 23/02/24"},{"id":7,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"Yash Sharma","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_dN7SLCu.jpg","connected_person_address":"Raipur","connected_person_user_id":44,"connected_person_user_type":"Agri Service Provider","last_message":"","unseen_message_count":0,"last_message_date":"","is_created_by_me":true,"created":"11:57 AM, 23/02/24"},{"id":8,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"Yash Sharma","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_bHowGu5.jpg","connected_person_address":"Mahasamund","connected_person_user_id":45,"connected_person_user_type":"Farmer","last_message":"","unseen_message_count":0,"last_message_date":"","is_created_by_me":true,"created":"11:58 AM, 23/02/24"},{"id":9,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"Aman tiwari","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_64FjkHc.jpg","connected_person_address":"Raipur","connected_person_user_id":46,"connected_person_user_type":"Farmer","last_message":"","unseen_message_count":0,"last_message_date":"","is_created_by_me":true,"created":"11:58 AM, 23/02/24"},{"id":10,"enquiry_type":"Land Enquiry","land":20,"connected_person_name":"Aman tiwari","connected_person_image":"http://139.5.189.24:8000/media/user_image/photo_mK0z18h.jpg","connected_person_address":"Mahasamund","connected_person_user_id":47,"connected_person_user_type":"Agri Service Provider","last_message":"","unseen_message_count":0,"last_message_date":"","is_created_by_me":true,"created":"11:58 AM, 23/02/24"}]
/// page_info : {"total_page":2,"total_object":12,"current_page":1}

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

/// total_page : 2
/// total_object : 12
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
/// enquiry_type : "Land Enquiry"
/// land : 20
/// connected_person_name : "Yash Sharma"
/// connected_person_image : "http://139.5.189.24:8000/media/user_image/photo_pIqzPBg.jpg"
/// connected_person_address : "Pandri, Raipur, Chhattisgarh"
/// connected_person_user_id : 1
/// connected_person_user_type : "Farmer"
/// last_message : "hi"
/// unseen_message_count : 0
/// last_message_date : "53 min ago"
/// is_created_by_me : true
/// created : "10:24 AM, 23/02/24"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      String? enquiryType, 
      num? land, 
      String? connectedPersonName, 
      String? connectedPersonImage, 
      String? connectedPersonAddress, 
      num? connectedPersonUserId, 
      String? connectedPersonUserType, 
      String? lastMessage, 
      num? unseenMessageCount, 
      String? lastMessageDate, 
      bool? isCreatedByMe, 
      String? created,}){
    _id = id;
    _enquiryType = enquiryType;
    _land = land;
    _connectedPersonName = connectedPersonName;
    _connectedPersonImage = connectedPersonImage;
    _connectedPersonAddress = connectedPersonAddress;
    _connectedPersonUserId = connectedPersonUserId;
    _connectedPersonUserType = connectedPersonUserType;
    _lastMessage = lastMessage;
    _unseenMessageCount = unseenMessageCount;
    _lastMessageDate = lastMessageDate;
    _isCreatedByMe = isCreatedByMe;
    _created = created;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _enquiryType = json['enquiry_type'];
    _land = json['land'];
    _connectedPersonName = json['connected_person_name'];
    _connectedPersonImage = json['connected_person_image'];
    _connectedPersonAddress = json['connected_person_address'];
    _connectedPersonUserId = json['connected_person_user_id'];
    _connectedPersonUserType = json['connected_person_user_type'];
    _lastMessage = json['last_message'];
    _unseenMessageCount = json['unseen_message_count'];
    _lastMessageDate = json['last_message_date'];
    _isCreatedByMe = json['is_created_by_me'];
    _created = json['created'];
  }
  num? _id;
  String? _enquiryType;
  num? _land;
  String? _connectedPersonName;
  String? _connectedPersonImage;
  String? _connectedPersonAddress;
  num? _connectedPersonUserId;
  String? _connectedPersonUserType;
  String? _lastMessage;
  num? _unseenMessageCount;
  String? _lastMessageDate;
  bool? _isCreatedByMe;
  String? _created;
Data copyWith({  num? id,
  String? enquiryType,
  num? land,
  String? connectedPersonName,
  String? connectedPersonImage,
  String? connectedPersonAddress,
  num? connectedPersonUserId,
  String? connectedPersonUserType,
  String? lastMessage,
  num? unseenMessageCount,
  String? lastMessageDate,
  bool? isCreatedByMe,
  String? created,
}) => Data(  id: id ?? _id,
  enquiryType: enquiryType ?? _enquiryType,
  land: land ?? _land,
  connectedPersonName: connectedPersonName ?? _connectedPersonName,
  connectedPersonImage: connectedPersonImage ?? _connectedPersonImage,
  connectedPersonAddress: connectedPersonAddress ?? _connectedPersonAddress,
  connectedPersonUserId: connectedPersonUserId ?? _connectedPersonUserId,
  connectedPersonUserType: connectedPersonUserType ?? _connectedPersonUserType,
  lastMessage: lastMessage ?? _lastMessage,
  unseenMessageCount: unseenMessageCount ?? _unseenMessageCount,
  lastMessageDate: lastMessageDate ?? _lastMessageDate,
  isCreatedByMe: isCreatedByMe ?? _isCreatedByMe,
  created: created ?? _created,
);
  num? get id => _id;
  String? get enquiryType => _enquiryType;
  num? get land => _land;
  String? get connectedPersonName => _connectedPersonName;
  String? get connectedPersonImage => _connectedPersonImage;
  String? get connectedPersonAddress => _connectedPersonAddress;
  num? get connectedPersonUserId => _connectedPersonUserId;
  String? get connectedPersonUserType => _connectedPersonUserType;
  String? get lastMessage => _lastMessage;
  num? get unseenMessageCount => _unseenMessageCount;
  String? get lastMessageDate => _lastMessageDate;
  bool? get isCreatedByMe => _isCreatedByMe;
  String? get created => _created;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['enquiry_type'] = _enquiryType;
    map['land'] = _land;
    map['connected_person_name'] = _connectedPersonName;
    map['connected_person_image'] = _connectedPersonImage;
    map['connected_person_address'] = _connectedPersonAddress;
    map['connected_person_user_id'] = _connectedPersonUserId;
    map['connected_person_user_type'] = _connectedPersonUserType;
    map['last_message'] = _lastMessage;
    map['unseen_message_count'] = _unseenMessageCount;
    map['last_message_date'] = _lastMessageDate;
    map['is_created_by_me'] = _isCreatedByMe;
    map['created'] = _created;
    return map;
  }

}