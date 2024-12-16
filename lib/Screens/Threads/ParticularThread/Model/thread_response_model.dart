class ParticularThreadResponseModel {
  String? detail;
  Result? result;

  ParticularThreadResponseModel({this.detail, this.result});

  ParticularThreadResponseModel.fromJson(Map<String, dynamic> json) {
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

  Result(
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

  Result.fromJson(Map<String, dynamic> json) {
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
