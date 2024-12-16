class ThreadListResponseModel {
  String? detail;
  Result? result;

  ThreadListResponseModel({this.detail, this.result});

  ThreadListResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? userId;
  String? userType;
  String? userImage;
  String? userName;
  List<Images>? images;
  String? title;
  String? description;
  List<Tags>? tags;
  bool? isLiked;
  int? totalLikes;
  int? totalReplies;
  String? createdOn;

  Data(
      {this.id,
        this.userId,
        this.userType,
        this.userImage,
        this.userName,
        this.images,
        this.title,
        this.description,
        this.tags,
        this.isLiked,
        this.totalLikes,
        this.totalReplies,
        this.createdOn});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userType = json['user_type'];
    userImage = json['user_image'];
    userName = json['user_name'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    title = json['title'];
    description = json['description'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(new Tags.fromJson(v));
      });
    }
    isLiked = json['is_liked'];
    totalLikes = json['total_likes'];
    totalReplies = json['total_replies'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['user_image'] = this.userImage;
    data['user_name'] = this.userName;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    data['is_liked'] = this.isLiked;
    data['total_likes'] = this.totalLikes;
    data['total_replies'] = this.totalReplies;
    data['created_on'] = this.createdOn;
    return data;
  }
}

class Images {
  String? image;

  Images({this.image});

  Images.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

class Tags {
  int? id;
  String? name;

  Tags({this.id, this.name});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
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