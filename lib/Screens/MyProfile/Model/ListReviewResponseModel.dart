class ListReviewResponseModel {
  String? detail;
  Result? result;

  ListReviewResponseModel({this.detail, this.result});

  ListReviewResponseModel.fromJson(Map<String, dynamic> json) {
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
  double? averageRating;

  Result({this.data, this.pageInfo, this.averageRating});

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
    averageRating = json['average_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pageInfo != null) {
      data['page_info'] = this.pageInfo!.toJson();
    }
    data['average_rating'] = this.averageRating;
    return data;
  }
}

class Data {
  int? id;
  String? reviewerUserType;
  int? reviewerUserId;
  String? reviewerName;
  String? reviewerLocation;
  String? reviewerImage;
  int? rating;
  String? description;
  String? date;

  Data(
      {this.id,
      this.reviewerUserType,
      this.reviewerUserId,
      this.reviewerName,
      this.reviewerLocation,
      this.reviewerImage,
      this.rating,
      this.description,
      this.date});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reviewerUserType = json['reviewer_user_type'];
    reviewerUserId = json['reviewer_user_id'];
    reviewerName = json['reviewer_name'];
    reviewerLocation = json['reviewer_location'];
    reviewerImage = json['reviewer_image'];
    rating = json['rating'];
    description = json['description'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reviewer_user_type'] = this.reviewerUserType;
    data['reviewer_user_id'] = this.reviewerUserId;
    data['reviewer_name'] = this.reviewerName;
    data['reviewer_location'] = this.reviewerLocation;
    data['reviewer_image'] = this.reviewerImage;
    data['rating'] = this.rating;
    data['description'] = this.description;
    data['date'] = this.date;
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
