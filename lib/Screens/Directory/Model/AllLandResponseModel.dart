import 'dart:convert';
/// detail : "Operation Successful"
/// result : {"data":[{"id":1,"land_owner_user_id":1,"land_owner_user_type":"Farmer","land_owner_name":"qwerty","land_owner_image":"","land_images":[{"image":"http://139.5.189.24:8000/media/land_images/photo.jpg"}],"city":"Raipur","state":"C.G","country":"India","land_size":"2 acre","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"},{"id":5,"name":"Potato"}],"purpose":{"id":2,"name":"Monetization"}},{"id":2,"land_owner_user_id":1,"land_owner_user_type":"Farmer","land_owner_name":"qwerty","land_owner_image":"","land_images":[],"city":"Raipur","state":"C.G","country":"India","land_size":"2 acre","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"},{"id":5,"name":"Potato"}],"purpose":{"id":2,"name":"Monetization"}},{"id":3,"land_owner_user_id":1,"land_owner_user_type":"Farmer","land_owner_name":"qwerty","land_owner_image":"","land_images":[],"city":"Raipur","state":"C.G","country":"India","land_size":"2 acre","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"},{"id":5,"name":"Potato"}],"purpose":{"id":2,"name":"Monetization"}},{"id":4,"land_owner_user_id":1,"land_owner_user_type":"Farmer","land_owner_name":"qwerty","land_owner_image":"","land_images":[],"city":"Raipur","state":"C.G","country":"India","land_size":"2 acre","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"},{"id":5,"name":"Potato"}],"purpose":{"id":2,"name":"Monetization"}},{"id":36,"land_owner_user_id":53,"land_owner_user_type":"Land Owner","land_owner_name":"Yash Sharma","land_owner_image":"","land_images":[],"city":"Raipur","state":"Chhattisgarh","country":"India","land_size":"2 Acers","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"}],"purpose":{"id":1,"name":"Give on lease for farming"}},{"id":37,"land_owner_user_id":54,"land_owner_user_type":"Land Owner","land_owner_name":"Yash Sharma","land_owner_image":"","land_images":[{"image":"http://139.5.189.24:8000/media/land_images/IMG-20240204-WA0045.jpg"}],"city":"Raipur","state":"Chhattisgarh","country":"India","land_size":"2 Acers","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"}],"purpose":{"id":1,"name":"Give on lease for farming"}},{"id":45,"land_owner_user_id":54,"land_owner_user_type":"Land Owner","land_owner_name":"Yash Sharma","land_owner_image":"","land_images":[],"city":"Raipur","state":"Chhattisgarh","country":"India","land_size":"2 Acers","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"}],"purpose":{"id":1,"name":"Give on lease for farming"}},{"id":47,"land_owner_user_id":54,"land_owner_user_type":"Land Owner","land_owner_name":"Yash Sharma","land_owner_image":"","land_images":[],"city":"Raipur","state":"chhattisgarh","country":"india","land_size":"2 Acers","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"}],"purpose":{"id":3,"name":"Food security"}},{"id":48,"land_owner_user_id":54,"land_owner_user_type":"Land Owner","land_owner_name":"Yash Sharma","land_owner_image":"","land_images":[],"city":"Raipur","state":"chhattisgarh","country":"india","land_size":"2 Acers","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"}],"purpose":{"id":3,"name":"Food security"}},{"id":50,"land_owner_user_id":54,"land_owner_user_type":"Land Owner","land_owner_name":"Yash Sharma","land_owner_image":"","land_images":[{"image":"http://139.5.189.24:8000/media/land_images/Screenshot_2024-02-15-19-57-05-556_com.android.chrome.jpg"},{"image":"http://139.5.189.24:8000/media/land_images/Screenshot_2024-02-15-19-57-05-556_com.android.chrome_9Sgak29.jpg"},{"image":"http://139.5.189.24:8000/media/land_images/Screenshot_2024-02-15-19-57-05-556_com.android.chrome_eJJ4bot.jpg"},{"image":"http://139.5.189.24:8000/media/land_images/Screenshot_2024-02-15-19-57-05-556_com.android.chrome_PT5ekxO.jpg"},{"image":"http://139.5.189.24:8000/media/land_images/Screenshot_2024-02-15-19-57-05-556_com.android.chrome_Cm87p51.jpg"}],"city":"Raipur","state":"chhattisgarh","country":"India","land_size":"2 Acers","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"}],"purpose":{"id":1,"name":"Give on lease for farming"}}],"page_info":{"total_page":3,"total_object":30,"current_page":1}}

AllLandResponseModel allLandResponseModelFromJson(String str) => AllLandResponseModel.fromJson(json.decode(str));
String allLandResponseModelToJson(AllLandResponseModel data) => json.encode(data.toJson());
class AllLandResponseModel {
  AllLandResponseModel({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  AllLandResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
AllLandResponseModel copyWith({  String? detail,
  Result? result,
}) => AllLandResponseModel(  detail: detail ?? _detail,
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

/// data : [{"id":1,"land_owner_user_id":1,"land_owner_user_type":"Farmer","land_owner_name":"qwerty","land_owner_image":"","land_images":[{"image":"http://139.5.189.24:8000/media/land_images/photo.jpg"}],"city":"Raipur","state":"C.G","country":"India","land_size":"2 acre","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"},{"id":5,"name":"Potato"}],"purpose":{"id":2,"name":"Monetization"}},{"id":2,"land_owner_user_id":1,"land_owner_user_type":"Farmer","land_owner_name":"qwerty","land_owner_image":"","land_images":[],"city":"Raipur","state":"C.G","country":"India","land_size":"2 acre","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"},{"id":5,"name":"Potato"}],"purpose":{"id":2,"name":"Monetization"}},{"id":3,"land_owner_user_id":1,"land_owner_user_type":"Farmer","land_owner_name":"qwerty","land_owner_image":"","land_images":[],"city":"Raipur","state":"C.G","country":"India","land_size":"2 acre","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"},{"id":5,"name":"Potato"}],"purpose":{"id":2,"name":"Monetization"}},{"id":4,"land_owner_user_id":1,"land_owner_user_type":"Farmer","land_owner_name":"qwerty","land_owner_image":"","land_images":[],"city":"Raipur","state":"C.G","country":"India","land_size":"2 acre","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"},{"id":5,"name":"Potato"}],"purpose":{"id":2,"name":"Monetization"}},{"id":36,"land_owner_user_id":53,"land_owner_user_type":"Land Owner","land_owner_name":"Yash Sharma","land_owner_image":"","land_images":[],"city":"Raipur","state":"Chhattisgarh","country":"India","land_size":"2 Acers","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"}],"purpose":{"id":1,"name":"Give on lease for farming"}},{"id":37,"land_owner_user_id":54,"land_owner_user_type":"Land Owner","land_owner_name":"Yash Sharma","land_owner_image":"","land_images":[{"image":"http://139.5.189.24:8000/media/land_images/IMG-20240204-WA0045.jpg"}],"city":"Raipur","state":"Chhattisgarh","country":"India","land_size":"2 Acers","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"}],"purpose":{"id":1,"name":"Give on lease for farming"}},{"id":45,"land_owner_user_id":54,"land_owner_user_type":"Land Owner","land_owner_name":"Yash Sharma","land_owner_image":"","land_images":[],"city":"Raipur","state":"Chhattisgarh","country":"India","land_size":"2 Acers","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"}],"purpose":{"id":1,"name":"Give on lease for farming"}},{"id":47,"land_owner_user_id":54,"land_owner_user_type":"Land Owner","land_owner_name":"Yash Sharma","land_owner_image":"","land_images":[],"city":"Raipur","state":"chhattisgarh","country":"india","land_size":"2 Acers","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"}],"purpose":{"id":3,"name":"Food security"}},{"id":48,"land_owner_user_id":54,"land_owner_user_type":"Land Owner","land_owner_name":"Yash Sharma","land_owner_image":"","land_images":[],"city":"Raipur","state":"chhattisgarh","country":"india","land_size":"2 Acers","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"}],"purpose":{"id":3,"name":"Food security"}},{"id":50,"land_owner_user_id":54,"land_owner_user_type":"Land Owner","land_owner_name":"Yash Sharma","land_owner_image":"","land_images":[{"image":"http://139.5.189.24:8000/media/land_images/Screenshot_2024-02-15-19-57-05-556_com.android.chrome.jpg"},{"image":"http://139.5.189.24:8000/media/land_images/Screenshot_2024-02-15-19-57-05-556_com.android.chrome_9Sgak29.jpg"},{"image":"http://139.5.189.24:8000/media/land_images/Screenshot_2024-02-15-19-57-05-556_com.android.chrome_eJJ4bot.jpg"},{"image":"http://139.5.189.24:8000/media/land_images/Screenshot_2024-02-15-19-57-05-556_com.android.chrome_PT5ekxO.jpg"},{"image":"http://139.5.189.24:8000/media/land_images/Screenshot_2024-02-15-19-57-05-556_com.android.chrome_Cm87p51.jpg"}],"city":"Raipur","state":"chhattisgarh","country":"India","land_size":"2 Acers","crop_to_grow":[{"id":1,"name":"Maize"},{"id":3,"name":"Rice"}],"purpose":{"id":1,"name":"Give on lease for farming"}}]
/// page_info : {"total_page":3,"total_object":30,"current_page":1}

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
/// total_object : 30
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
/// land_owner_user_id : 1
/// land_owner_user_type : "Farmer"
/// land_owner_name : "qwerty"
/// land_owner_image : ""
/// land_images : [{"image":"http://139.5.189.24:8000/media/land_images/photo.jpg"}]
/// city : "Raipur"
/// state : "C.G"
/// country : "India"
/// land_size : "2 acre"
/// crop_to_grow : [{"id":1,"name":"Maize"},{"id":3,"name":"Rice"},{"id":5,"name":"Potato"}]
/// purpose : {"id":2,"name":"Monetization"}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      num? landOwnerUserId, 
      String? landOwnerUserType, 
      String? landOwnerName, 
      String? landOwnerImage, 
      List<LandImages>? landImages, 
      String? city, 
      String? state, 
      String? country, 
      String? landSize, 
      List<CropToGrow>? cropToGrow, 
      Purpose? purpose,}){
    _id = id;
    _landOwnerUserId = landOwnerUserId;
    _landOwnerUserType = landOwnerUserType;
    _landOwnerName = landOwnerName;
    _landOwnerImage = landOwnerImage;
    _landImages = landImages;
    _city = city;
    _state = state;
    _country = country;
    _landSize = landSize;
    _cropToGrow = cropToGrow;
    _purpose = purpose;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _landOwnerUserId = json['land_owner_user_id'];
    _landOwnerUserType = json['land_owner_user_type'];
    _landOwnerName = json['land_owner_name'];
    _landOwnerImage = json['land_owner_image'];
    if (json['land_images'] != null) {
      _landImages = [];
      json['land_images'].forEach((v) {
        _landImages?.add(LandImages.fromJson(v));
      });
    }
    _city = json['city'];
    _state = json['state'];
    _country = json['country'];
    _landSize = json['land_size'];
    if (json['crop_to_grow'] != null) {
      _cropToGrow = [];
      json['crop_to_grow'].forEach((v) {
        _cropToGrow?.add(CropToGrow.fromJson(v));
      });
    }
    _purpose = json['purpose'] != null ? Purpose.fromJson(json['purpose']) : null;
  }
  num? _id;
  num? _landOwnerUserId;
  String? _landOwnerUserType;
  String? _landOwnerName;
  String? _landOwnerImage;
  List<LandImages>? _landImages;
  String? _city;
  String? _state;
  String? _country;
  String? _landSize;
  List<CropToGrow>? _cropToGrow;
  Purpose? _purpose;
Data copyWith({  num? id,
  num? landOwnerUserId,
  String? landOwnerUserType,
  String? landOwnerName,
  String? landOwnerImage,
  List<LandImages>? landImages,
  String? city,
  String? state,
  String? country,
  String? landSize,
  List<CropToGrow>? cropToGrow,
  Purpose? purpose,
}) => Data(  id: id ?? _id,
  landOwnerUserId: landOwnerUserId ?? _landOwnerUserId,
  landOwnerUserType: landOwnerUserType ?? _landOwnerUserType,
  landOwnerName: landOwnerName ?? _landOwnerName,
  landOwnerImage: landOwnerImage ?? _landOwnerImage,
  landImages: landImages ?? _landImages,
  city: city ?? _city,
  state: state ?? _state,
  country: country ?? _country,
  landSize: landSize ?? _landSize,
  cropToGrow: cropToGrow ?? _cropToGrow,
  purpose: purpose ?? _purpose,
);
  num? get id => _id;
  num? get landOwnerUserId => _landOwnerUserId;
  String? get landOwnerUserType => _landOwnerUserType;
  String? get landOwnerName => _landOwnerName;
  String? get landOwnerImage => _landOwnerImage;
  List<LandImages>? get landImages => _landImages;
  String? get city => _city;
  String? get state => _state;
  String? get country => _country;
  String? get landSize => _landSize;
  List<CropToGrow>? get cropToGrow => _cropToGrow;
  Purpose? get purpose => _purpose;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['land_owner_user_id'] = _landOwnerUserId;
    map['land_owner_user_type'] = _landOwnerUserType;
    map['land_owner_name'] = _landOwnerName;
    map['land_owner_image'] = _landOwnerImage;
    if (_landImages != null) {
      map['land_images'] = _landImages?.map((v) => v.toJson()).toList();
    }
    map['city'] = _city;
    map['state'] = _state;
    map['country'] = _country;
    map['land_size'] = _landSize;
    if (_cropToGrow != null) {
      map['crop_to_grow'] = _cropToGrow?.map((v) => v.toJson()).toList();
    }
    if (_purpose != null) {
      map['purpose'] = _purpose?.toJson();
    }
    return map;
  }

}

/// id : 2
/// name : "Monetization"

Purpose purposeFromJson(String str) => Purpose.fromJson(json.decode(str));
String purposeToJson(Purpose data) => json.encode(data.toJson());
class Purpose {
  Purpose({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Purpose.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
Purpose copyWith({  num? id,
  String? name,
}) => Purpose(  id: id ?? _id,
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

/// id : 1
/// name : "Maize"

CropToGrow cropToGrowFromJson(String str) => CropToGrow.fromJson(json.decode(str));
String cropToGrowToJson(CropToGrow data) => json.encode(data.toJson());
class CropToGrow {
  CropToGrow({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  CropToGrow.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
CropToGrow copyWith({  num? id,
  String? name,
}) => CropToGrow(  id: id ?? _id,
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

/// image : "http://139.5.189.24:8000/media/land_images/photo.jpg"

LandImages landImagesFromJson(String str) => LandImages.fromJson(json.decode(str));
String landImagesToJson(LandImages data) => json.encode(data.toJson());
class LandImages {
  LandImages({
      String? image,}){
    _image = image;
}

  LandImages.fromJson(dynamic json) {
    _image = json['image'];
  }
  String? _image;
LandImages copyWith({  String? image,
}) => LandImages(  image: image ?? _image,
);
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = _image;
    return map;
  }

}