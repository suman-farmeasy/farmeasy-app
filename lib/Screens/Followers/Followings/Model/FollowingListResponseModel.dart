class FollowingListResponseModel {
  String? detail;
  Result? result;

  FollowingListResponseModel({this.detail, this.result});

  FollowingListResponseModel.fromJson(Map<String, dynamic> json) {
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
  PageInfo? pageInfo;

  Result({this.data, this.pageInfo});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pageInfo = json['page_info'] != null
        ? new PageInfo.fromJson(json['page_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pageInfo != null) {
      data['page_info'] = this.pageInfo!.toJson();
    }
    return data;
  }
}

class Data {
  int? followingUserId;
  String? followingUserType;
  String? followingUserName;
  String? followingUserImage;
  String? followingUserAddress;
  bool? isFollowing;

  Data(
      {this.followingUserId,
        this.followingUserType,
        this.followingUserName,
        this.followingUserImage,
        this.followingUserAddress,
        this.isFollowing});

  Data.fromJson(Map<String, dynamic> json) {
    followingUserId = json['following_user_id'];
    followingUserType = json['following_user_type'];
    followingUserName = json['following_user_name'];
    followingUserImage = json['following_user_image'];
    followingUserAddress = json['following_user_address'];
    isFollowing = json['is_following'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['following_user_id'] = this.followingUserId;
    data['following_user_type'] = this.followingUserType;
    data['following_user_name'] = this.followingUserName;
    data['following_user_image'] = this.followingUserImage;
    data['following_user_address'] = this.followingUserAddress;
    data['is_following'] = this.isFollowing;
    return data;
  }
}

class PageInfo {
  int? totalPage;
  int? totalObject;
  int? currentPage;

  PageInfo({this.totalPage, this.totalObject, this.currentPage});

  PageInfo.fromJson(Map<String, dynamic> json) {
    totalPage = json['total_page'];
    totalObject = json['total_object'];
    currentPage = json['current_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_page'] = this.totalPage;
    data['total_object'] = this.totalObject;
    data['current_page'] = this.currentPage;
    return data;
  }
}