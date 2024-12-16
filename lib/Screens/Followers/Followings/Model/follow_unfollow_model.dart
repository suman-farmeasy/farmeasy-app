class FollowUnfollowResponseModel {
  String? detail;
  Result? result;

  FollowUnfollowResponseModel({this.detail, this.result});

  FollowUnfollowResponseModel.fromJson(Map<String, dynamic> json) {
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
  bool? isFollowing;

  Result({this.isFollowing});

  Result.fromJson(Map<String, dynamic> json) {
    isFollowing = json['is_following'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_following'] = this.isFollowing;
    return data;
  }
}