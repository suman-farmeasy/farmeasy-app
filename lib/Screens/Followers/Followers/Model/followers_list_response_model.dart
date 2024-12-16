class FollowersListResponseModel {
  String? detail;
  Result? result;

  FollowersListResponseModel({this.detail, this.result});

  FollowersListResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? followerUserId;
  String? followerUserType;
  String? followerName;
  String? followerImage;
  String? followerAddress;
  bool? isFollowing;

  Data(
      {this.followerUserId,
        this.followerUserType,
        this.followerName,
        this.followerImage,
        this.followerAddress,
        this.isFollowing});

  Data.fromJson(Map<String, dynamic> json) {
    followerUserId = json['follower_user_id'];
    followerUserType = json['follower_user_type'];
    followerName = json['follower_name'];
    followerImage = json['follower_image'];
    followerAddress = json['follower_address'];
    isFollowing = json['is_following'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['follower_user_id'] = this.followerUserId;
    data['follower_user_type'] = this.followerUserType;
    data['follower_name'] = this.followerName;
    data['follower_image'] = this.followerImage;
    data['follower_address'] = this.followerAddress;
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