import 'dart:convert';
/// detail : "Operation Successful"
/// result : {"data":[{"id":20,"user_id":1,"user_type":"Farmer","profile_type":"Land Owner","full_name":"qwerty","lives_in":"Pandri, Raipur, Chhattisgarh","image":null,"total_lands":6,"enquiry_id":null},{"id":21,"user_id":53,"user_type":"Land Owner","profile_type":"Land Owner","full_name":"Yash Sharma","lives_in":"Pandri, Raipur, Chhattisgarh","image":null,"total_lands":1,"enquiry_id":null},{"id":22,"user_id":54,"user_type":"Land Owner","profile_type":"Land Owner","full_name":"Yash Sharma","lives_in":"Pandri, Raipur, Chhattisgarh","image":null,"total_lands":5,"enquiry_id":null},{"id":23,"user_id":56,"user_type":"Land Owner","profile_type":"Land Owner","full_name":"sahil","lives_in":"Union Square, San Francisco, CA","image":null,"total_lands":0,"enquiry_id":null},{"id":24,"user_id":57,"user_type":"Land Owner","profile_type":"Land Owner","full_name":"Meghal Agrawal","lives_in":"Pandri, Raipur, Chhattisgarh","image":null,"total_lands":1,"enquiry_id":null},{"id":25,"user_id":58,"user_type":"Land Owner","profile_type":"Agent","full_name":"sahil","lives_in":"Davendra Nagar, Raipur, CT","image":null,"total_lands":1,"enquiry_id":null},{"id":26,"user_id":59,"user_type":"Land Owner","profile_type":"Land Owner","full_name":"sahil","lives_in":"Pandri, Raipur, Chhattisgarh","image":null,"total_lands":0,"enquiry_id":null},{"id":29,"user_id":62,"user_type":"Land Owner","profile_type":"Land Owner","full_name":"Shri","lives_in":"Davendra Nagar, Raipur, CT","image":null,"total_lands":1,"enquiry_id":null},{"id":30,"user_id":64,"user_type":"Land Owner","profile_type":"Land Owner","full_name":"Derrick P S","lives_in":"Davendra Nagar, Raipur, CT","image":null,"total_lands":0,"enquiry_id":null},{"id":31,"user_id":65,"user_type":"Land Owner","profile_type":"Land Owner","full_name":"Dev P S","lives_in":"Pandri, Raipur, Chhattisgarh","image":null,"total_lands":1,"enquiry_id":null}],"page_info":{"total_page":3,"total_object":27,"current_page":1}}

ListLandOwnerResponseModel listLandOwnerResponseModelFromJson(String str) => ListLandOwnerResponseModel.fromJson(json.decode(str));
String listLandOwnerResponseModelToJson(ListLandOwnerResponseModel data) => json.encode(data.toJson());
class ListLandOwnerResponseModel {
  ListLandOwnerResponseModel({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  ListLandOwnerResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
ListLandOwnerResponseModel copyWith({  String? detail,
  Result? result,
}) => ListLandOwnerResponseModel(  detail: detail ?? _detail,
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

/// data : [{"id":20,"user_id":1,"user_type":"Farmer","profile_type":"Land Owner","full_name":"qwerty","lives_in":"Pandri, Raipur, Chhattisgarh","image":null,"total_lands":6,"enquiry_id":null},{"id":21,"user_id":53,"user_type":"Land Owner","profile_type":"Land Owner","full_name":"Yash Sharma","lives_in":"Pandri, Raipur, Chhattisgarh","image":null,"total_lands":1,"enquiry_id":null},{"id":22,"user_id":54,"user_type":"Land Owner","profile_type":"Land Owner","full_name":"Yash Sharma","lives_in":"Pandri, Raipur, Chhattisgarh","image":null,"total_lands":5,"enquiry_id":null},{"id":23,"user_id":56,"user_type":"Land Owner","profile_type":"Land Owner","full_name":"sahil","lives_in":"Union Square, San Francisco, CA","image":null,"total_lands":0,"enquiry_id":null},{"id":24,"user_id":57,"user_type":"Land Owner","profile_type":"Land Owner","full_name":"Meghal Agrawal","lives_in":"Pandri, Raipur, Chhattisgarh","image":null,"total_lands":1,"enquiry_id":null},{"id":25,"user_id":58,"user_type":"Land Owner","profile_type":"Agent","full_name":"sahil","lives_in":"Davendra Nagar, Raipur, CT","image":null,"total_lands":1,"enquiry_id":null},{"id":26,"user_id":59,"user_type":"Land Owner","profile_type":"Land Owner","full_name":"sahil","lives_in":"Pandri, Raipur, Chhattisgarh","image":null,"total_lands":0,"enquiry_id":null},{"id":29,"user_id":62,"user_type":"Land Owner","profile_type":"Land Owner","full_name":"Shri","lives_in":"Davendra Nagar, Raipur, CT","image":null,"total_lands":1,"enquiry_id":null},{"id":30,"user_id":64,"user_type":"Land Owner","profile_type":"Land Owner","full_name":"Derrick P S","lives_in":"Davendra Nagar, Raipur, CT","image":null,"total_lands":0,"enquiry_id":null},{"id":31,"user_id":65,"user_type":"Land Owner","profile_type":"Land Owner","full_name":"Dev P S","lives_in":"Pandri, Raipur, Chhattisgarh","image":null,"total_lands":1,"enquiry_id":null}]
/// page_info : {"total_page":3,"total_object":27,"current_page":1}

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

/// total_page : 3
/// total_object : 27
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

/// id : 20
/// user_id : 1
/// user_type : "Farmer"
/// profile_type : "Land Owner"
/// full_name : "qwerty"
/// lives_in : "Pandri, Raipur, Chhattisgarh"
/// image : null
/// total_lands : 6
/// enquiry_id : null

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      num? userId, 
      String? userType, 
      String? profileType, 
      String? fullName, 
      String? livesIn, 
      dynamic image, 
      num? totalLands, 
      dynamic enquiryId,}){
    _id = id;
    _userId = userId;
    _userType = userType;
    _profileType = profileType;
    _fullName = fullName;
    _livesIn = livesIn;
    _image = image;
    _totalLands = totalLands;
    _enquiryId = enquiryId;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _userType = json['user_type'];
    _profileType = json['profile_type'];
    _fullName = json['full_name'];
    _livesIn = json['lives_in'];
    _image = json['image'];
    _totalLands = json['total_lands'];
    _enquiryId = json['enquiry_id'];
  }
  num? _id;
  num? _userId;
  String? _userType;
  String? _profileType;
  String? _fullName;
  String? _livesIn;
  dynamic _image;
  num? _totalLands;
  dynamic _enquiryId;
Data copyWith({  num? id,
  num? userId,
  String? userType,
  String? profileType,
  String? fullName,
  String? livesIn,
  dynamic image,
  num? totalLands,
  dynamic enquiryId,
}) => Data(  id: id ?? _id,
  userId: userId ?? _userId,
  userType: userType ?? _userType,
  profileType: profileType ?? _profileType,
  fullName: fullName ?? _fullName,
  livesIn: livesIn ?? _livesIn,
  image: image ?? _image,
  totalLands: totalLands ?? _totalLands,
  enquiryId: enquiryId ?? _enquiryId,
);
  num? get id => _id;
  num? get userId => _userId;
  String? get userType => _userType;
  String? get profileType => _profileType;
  String? get fullName => _fullName;
  String? get livesIn => _livesIn;
  dynamic get image => _image;
  num? get totalLands => _totalLands;
  dynamic get enquiryId => _enquiryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['user_type'] = _userType;
    map['profile_type'] = _profileType;
    map['full_name'] = _fullName;
    map['lives_in'] = _livesIn;
    map['image'] = _image;
    map['total_lands'] = _totalLands;
    map['enquiry_id'] = _enquiryId;
    return map;
  }

}