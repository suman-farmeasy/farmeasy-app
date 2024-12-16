class RecommendedLandownersResponseModel {
  String? detail;
  Result? result;

  RecommendedLandownersResponseModel({this.detail, this.result});

  RecommendedLandownersResponseModel.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detail'] = this.detail;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  List<Data>? data;
  int? count;

  Result({this.data, this.count});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Data {
  int? id;
  int? userId;
  String? userType;
  String? profileType;
  String? fullName;
  String? livesIn;
  String? image;
  int? totalLands;
  int? enquiryId;

  Data(
      {this.id,
      this.userId,
      this.userType,
      this.profileType,
      this.fullName,
      this.livesIn,
      this.image,
      this.totalLands,
      this.enquiryId});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userType = json['user_type'];
    profileType = json['profile_type'];
    fullName = json['full_name'];
    livesIn = json['lives_in'];
    image = json['image'];
    totalLands = json['total_lands'];
    enquiryId = json['enquiry_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['profile_type'] = this.profileType;
    data['full_name'] = this.fullName;
    data['lives_in'] = this.livesIn;
    data['image'] = this.image;
    data['total_lands'] = this.totalLands;
    data['enquiry_id'] = this.enquiryId;
    return data;
  }
}
