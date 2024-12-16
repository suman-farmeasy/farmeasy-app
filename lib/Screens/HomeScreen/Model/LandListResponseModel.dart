import 'dart:convert';
/// detail : "Operation Successful"
/// result : {"data":[{"id":112,"land_title":null,"weather_details":{"temperature":33.35,"img_icon":"01d","description":"clear sky","min_temp":36.14,"max_temp":36.14},"images":[{"image":"http://139.5.189.24:8000/media/land_images/1000021500_rK1NauY.jpg"},{"image":"http://139.5.189.24:8000/media/land_images/1000021501.jpg"},{"image":"http://139.5.189.24:8000/media/land_images/1000021499.jpg"}],"city":"Solan","state":"Himachal Pradesh","country":"India","land_size":"2 Acres","crop_to_grow":[{"id":9,"name":"Maize (corn)"},{"id":10,"name":"Millet"},{"id":11,"name":"Sorghum"},{"id":12,"name":"Beans"},{"id":13,"name":"Potatoes"}],"total_matching_farmer":0,"total_agri_service_provider":1},{"id":111,"land_title":null,"weather_details":{"temperature":33.35,"img_icon":"01d","description":"clear sky","min_temp":36.14,"max_temp":36.14},"images":[{"image":"http://139.5.189.24:8000/media/land_images/1000021500_rK1NauY.jpg"},{"image":"http://139.5.189.24:8000/media/land_images/1000021501.jpg"},{"image":"http://139.5.189.24:8000/media/land_images/1000021499.jpg"}],"city":"Solan","state":"Himachal Pradesh","country":"India","land_size":"2 Acres","crop_to_grow":[{"id":1,"name":"Maize"},{"id":2,"name":"Wheat"},{"id":6,"name":"Pineapple"},{"id":7,"name":"Teff"},{"id":9,"name":"Maize (corn)"}],"total_matching_farmer":0,"total_agri_service_provider":1}],"page_info":{"total_page":2,"total_object":4,"current_page":1}}

LandListResponseModel landListResponseModelFromJson(String str) => LandListResponseModel.fromJson(json.decode(str));
String landListResponseModelToJson(LandListResponseModel data) => json.encode(data.toJson());
class LandListResponseModel {
  LandListResponseModel({
      String? detail, 
      Result? result,}){
    _detail = detail;
    _result = result;
}

  LandListResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    _result = json['result'] != null ? Result.fromJson(json['result']) : null;
  }
  String? _detail;
  Result? _result;
LandListResponseModel copyWith({  String? detail,
  Result? result,
}) => LandListResponseModel(  detail: detail ?? _detail,
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

/// data : [{"id":112,"land_title":null,"weather_details":{"temperature":33.35,"img_icon":"01d","description":"clear sky","min_temp":36.14,"max_temp":36.14},"images":[{"image":"http://139.5.189.24:8000/media/land_images/1000021500_rK1NauY.jpg"},{"image":"http://139.5.189.24:8000/media/land_images/1000021501.jpg"},{"image":"http://139.5.189.24:8000/media/land_images/1000021499.jpg"}],"city":"Solan","state":"Himachal Pradesh","country":"India","land_size":"2 Acres","crop_to_grow":[{"id":9,"name":"Maize (corn)"},{"id":10,"name":"Millet"},{"id":11,"name":"Sorghum"},{"id":12,"name":"Beans"},{"id":13,"name":"Potatoes"}],"total_matching_farmer":0,"total_agri_service_provider":1},{"id":111,"land_title":null,"weather_details":{"temperature":33.35,"img_icon":"01d","description":"clear sky","min_temp":36.14,"max_temp":36.14},"images":[{"image":"http://139.5.189.24:8000/media/land_images/1000021500_rK1NauY.jpg"},{"image":"http://139.5.189.24:8000/media/land_images/1000021501.jpg"},{"image":"http://139.5.189.24:8000/media/land_images/1000021499.jpg"}],"city":"Solan","state":"Himachal Pradesh","country":"India","land_size":"2 Acres","crop_to_grow":[{"id":1,"name":"Maize"},{"id":2,"name":"Wheat"},{"id":6,"name":"Pineapple"},{"id":7,"name":"Teff"},{"id":9,"name":"Maize (corn)"}],"total_matching_farmer":0,"total_agri_service_provider":1}]
/// page_info : {"total_page":2,"total_object":4,"current_page":1}

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      List<LandDetailsData>? data,
      PageInfo? pageInfo,}){
    _data = data;
    _pageInfo = pageInfo;
}

  Result.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(LandDetailsData.fromJson(v));
      });
    }
    _pageInfo = json['page_info'] != null ? PageInfo.fromJson(json['page_info']) : null;
  }
  List<LandDetailsData>? _data;
  PageInfo? _pageInfo;
Result copyWith({  List<LandDetailsData>? data,
  PageInfo? pageInfo,
}) => Result(  data: data ?? _data,
  pageInfo: pageInfo ?? _pageInfo,
);
  List<LandDetailsData>? get data => _data;
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
/// total_object : 4
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

/// id : 112
/// land_title : null
/// weather_details : {"temperature":33.35,"img_icon":"01d","description":"clear sky","min_temp":36.14,"max_temp":36.14}
/// images : [{"image":"http://139.5.189.24:8000/media/land_images/1000021500_rK1NauY.jpg"},{"image":"http://139.5.189.24:8000/media/land_images/1000021501.jpg"},{"image":"http://139.5.189.24:8000/media/land_images/1000021499.jpg"}]
/// city : "Solan"
/// state : "Himachal Pradesh"
/// country : "India"
/// land_size : "2 Acres"
/// crop_to_grow : [{"id":9,"name":"Maize (corn)"},{"id":10,"name":"Millet"},{"id":11,"name":"Sorghum"},{"id":12,"name":"Beans"},{"id":13,"name":"Potatoes"}]
/// total_matching_farmer : 0
/// total_agri_service_provider : 1

LandDetailsData dataFromJson(String str) => LandDetailsData.fromJson(json.decode(str));
String dataToJson(LandDetailsData data) => json.encode(data.toJson());
class LandDetailsData {
  LandDetailsData({
      num? id, 
      dynamic landTitle, 
      WeatherDetails? weatherDetails, 
      List<Images>? images, 
      String? city, 
      String? state, 
      String? country, 
      String? landSize, 
      List<CropToGrow>? cropToGrow, 
      num? totalMatchingFarmer, 
      num? totalAgriServiceProvider,}){
    _id = id;
    _landTitle = landTitle;
    _weatherDetails = weatherDetails;
    _images = images;
    _city = city;
    _state = state;
    _country = country;
    _landSize = landSize;
    _cropToGrow = cropToGrow;
    _totalMatchingFarmer = totalMatchingFarmer;
    _totalAgriServiceProvider = totalAgriServiceProvider;
}

  LandDetailsData.fromJson(dynamic json) {
    _id = json['id'];
    _landTitle = json['land_title'];
    _weatherDetails = json['weather_details'] != null ? WeatherDetails.fromJson(json['weather_details']) : null;
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
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
    _totalMatchingFarmer = json['total_matching_farmer'];
    _totalAgriServiceProvider = json['total_agri_service_provider'];
  }
  num? _id;
  dynamic _landTitle;
  WeatherDetails? _weatherDetails;
  List<Images>? _images;
  String? _city;
  String? _state;
  String? _country;
  String? _landSize;
  List<CropToGrow>? _cropToGrow;
  num? _totalMatchingFarmer;
  num? _totalAgriServiceProvider;
  LandDetailsData copyWith({  num? id,
  dynamic landTitle,
  WeatherDetails? weatherDetails,
  List<Images>? images,
  String? city,
  String? state,
  String? country,
  String? landSize,
  List<CropToGrow>? cropToGrow,
  num? totalMatchingFarmer,
  num? totalAgriServiceProvider,
}) => LandDetailsData(  id: id ?? _id,
  landTitle: landTitle ?? _landTitle,
  weatherDetails: weatherDetails ?? _weatherDetails,
  images: images ?? _images,
  city: city ?? _city,
  state: state ?? _state,
  country: country ?? _country,
  landSize: landSize ?? _landSize,
  cropToGrow: cropToGrow ?? _cropToGrow,
  totalMatchingFarmer: totalMatchingFarmer ?? _totalMatchingFarmer,
  totalAgriServiceProvider: totalAgriServiceProvider ?? _totalAgriServiceProvider,
);
  num? get id => _id;
  dynamic get landTitle => _landTitle;
  WeatherDetails? get weatherDetails => _weatherDetails;
  List<Images>? get images => _images;
  String? get city => _city;
  String? get state => _state;
  String? get country => _country;
  String? get landSize => _landSize;
  List<CropToGrow>? get cropToGrow => _cropToGrow;
  num? get totalMatchingFarmer => _totalMatchingFarmer;
  num? get totalAgriServiceProvider => _totalAgriServiceProvider;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['land_title'] = _landTitle;
    if (_weatherDetails != null) {
      map['weather_details'] = _weatherDetails?.toJson();
    }
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    map['city'] = _city;
    map['state'] = _state;
    map['country'] = _country;
    map['land_size'] = _landSize;
    if (_cropToGrow != null) {
      map['crop_to_grow'] = _cropToGrow?.map((v) => v.toJson()).toList();
    }
    map['total_matching_farmer'] = _totalMatchingFarmer;
    map['total_agri_service_provider'] = _totalAgriServiceProvider;
    return map;
  }

}

/// id : 9
/// name : "Maize (corn)"

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

/// image : "http://139.5.189.24:8000/media/land_images/1000021500_rK1NauY.jpg"

Images imagesFromJson(String str) => Images.fromJson(json.decode(str));
String imagesToJson(Images data) => json.encode(data.toJson());
class Images {
  Images({
      String? image,}){
    _image = image;
}

  Images.fromJson(dynamic json) {
    _image = json['image'];
  }
  String? _image;
Images copyWith({  String? image,
}) => Images(  image: image ?? _image,
);
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = _image;
    return map;
  }

}

/// temperature : 33.35
/// img_icon : "01d"
/// description : "clear sky"
/// min_temp : 36.14
/// max_temp : 36.14

WeatherDetails weatherDetailsFromJson(String str) => WeatherDetails.fromJson(json.decode(str));
String weatherDetailsToJson(WeatherDetails data) => json.encode(data.toJson());
class WeatherDetails {
  WeatherDetails({
      num? temperature, 
      String? imgIcon, 
      String? description, 
      num? minTemp, 
      num? maxTemp,}){
    _temperature = temperature;
    _imgIcon = imgIcon;
    _description = description;
    _minTemp = minTemp;
    _maxTemp = maxTemp;
}

  WeatherDetails.fromJson(dynamic json) {
    _temperature = json['temperature'];
    _imgIcon = json['img_icon'];
    _description = json['description'];
    _minTemp = json['min_temp'];
    _maxTemp = json['max_temp'];
  }
  num? _temperature;
  String? _imgIcon;
  String? _description;
  num? _minTemp;
  num? _maxTemp;
WeatherDetails copyWith({  num? temperature,
  String? imgIcon,
  String? description,
  num? minTemp,
  num? maxTemp,
}) => WeatherDetails(  temperature: temperature ?? _temperature,
  imgIcon: imgIcon ?? _imgIcon,
  description: description ?? _description,
  minTemp: minTemp ?? _minTemp,
  maxTemp: maxTemp ?? _maxTemp,
);
  num? get temperature => _temperature;
  String? get imgIcon => _imgIcon;
  String? get description => _description;
  num? get minTemp => _minTemp;
  num? get maxTemp => _maxTemp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['temperature'] = _temperature;
    map['img_icon'] = _imgIcon;
    map['description'] = _description;
    map['min_temp'] = _minTemp;
    map['max_temp'] = _maxTemp;
    return map;
  }

}