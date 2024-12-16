import 'dart:convert';
/// detail : "Operation Successful"
/// result : {"data":[{"id":7,"reviewer_user_type":"Land Owner","reviewer_user_id":184,"reviewer_name":"sam","reviewer_image":"","rating":5,"description":"nice person"},{"id":6,"reviewer_user_type":"Farmer","reviewer_user_id":183,"reviewer_name":"Yash","reviewer_image":"http://139.5.189.24:8000/media/user_image/image_cropper_1717070751932.jpg","rating":1,"description":"this is good landowner"}],"page_info":{"total_page":1,"total_object":2,"current_page":1},"average_rating":3.0}

ListReviewResponseModel listReviewResponseModelFromJson(String str) => ListReviewResponseModel.fromJson(json.decode(str));
String listReviewResponseModelToJson(ListReviewResponseModel data) => json.encode(data.toJson());
class ListReviewResponseModel {
  ListReviewResponseModel({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  ListReviewResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
ListReviewResponseModel copyWith({  String? detail,
  Result? result,
}) => ListReviewResponseModel(  detail: detail ?? _detail,
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

/// data : [{"id":7,"reviewer_user_type":"Land Owner","reviewer_user_id":184,"reviewer_name":"sam","reviewer_image":"","rating":5,"description":"nice person"},{"id":6,"reviewer_user_type":"Farmer","reviewer_user_id":183,"reviewer_name":"Yash","reviewer_image":"http://139.5.189.24:8000/media/user_image/image_cropper_1717070751932.jpg","rating":1,"description":"this is good landowner"}]
/// page_info : {"total_page":1,"total_object":2,"current_page":1}
/// average_rating : 3.0

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      List<Data>? data, 
      PageInfo? pageInfo, 
      num? averageRating,}){
    _data = data;
    _pageInfo = pageInfo;
    _averageRating = averageRating;
}

  Result.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _pageInfo = json['page_info'] != null ? PageInfo.fromJson(json['page_info']) : null;
    _averageRating = json['average_rating'];
  }
  List<Data>? _data;
  PageInfo? _pageInfo;
  num? _averageRating;
Result copyWith({  List<Data>? data,
  PageInfo? pageInfo,
  num? averageRating,
}) => Result(  data: data ?? _data,
  pageInfo: pageInfo ?? _pageInfo,
  averageRating: averageRating ?? _averageRating,
);
  List<Data>? get data => _data;
  PageInfo? get pageInfo => _pageInfo;
  num? get averageRating => _averageRating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_pageInfo != null) {
      map['page_info'] = _pageInfo?.toJson();
    }
    map['average_rating'] = _averageRating;
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

/// id : 7
/// reviewer_user_type : "Land Owner"
/// reviewer_user_id : 184
/// reviewer_name : "sam"
/// reviewer_image : ""
/// rating : 5
/// description : "nice person"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      String? reviewerUserType, 
      num? reviewerUserId, 
      String? reviewerName, 
      String? reviewerImage, 
      num? rating, 
      String? description,}){
    _id = id;
    _reviewerUserType = reviewerUserType;
    _reviewerUserId = reviewerUserId;
    _reviewerName = reviewerName;
    _reviewerImage = reviewerImage;
    _rating = rating;
    _description = description;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _reviewerUserType = json['reviewer_user_type'];
    _reviewerUserId = json['reviewer_user_id'];
    _reviewerName = json['reviewer_name'];
    _reviewerImage = json['reviewer_image'];
    _rating = json['rating'];
    _description = json['description'];
  }
  num? _id;
  String? _reviewerUserType;
  num? _reviewerUserId;
  String? _reviewerName;
  String? _reviewerImage;
  num? _rating;
  String? _description;
Data copyWith({  num? id,
  String? reviewerUserType,
  num? reviewerUserId,
  String? reviewerName,
  String? reviewerImage,
  num? rating,
  String? description,
}) => Data(  id: id ?? _id,
  reviewerUserType: reviewerUserType ?? _reviewerUserType,
  reviewerUserId: reviewerUserId ?? _reviewerUserId,
  reviewerName: reviewerName ?? _reviewerName,
  reviewerImage: reviewerImage ?? _reviewerImage,
  rating: rating ?? _rating,
  description: description ?? _description,
);
  num? get id => _id;
  String? get reviewerUserType => _reviewerUserType;
  num? get reviewerUserId => _reviewerUserId;
  String? get reviewerName => _reviewerName;
  String? get reviewerImage => _reviewerImage;
  num? get rating => _rating;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['reviewer_user_type'] = _reviewerUserType;
    map['reviewer_user_id'] = _reviewerUserId;
    map['reviewer_name'] = _reviewerName;
    map['reviewer_image'] = _reviewerImage;
    map['rating'] = _rating;
    map['description'] = _description;
    return map;
  }

}