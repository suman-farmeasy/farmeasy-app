class GetProfileResponseModel {
  String? detail;
  Result? result;

  GetProfileResponseModel({this.detail, this.result});

  GetProfileResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? fullName;
  String? contactDetail;
  String? livesIn;
  String? bio;
  List<Expertise>? expertise;
  String? image;
  String? countryCode;
  String? mobile;
  String? profileType;
  String? instagramUrl;
  String? facebookUrl;
  String? twitterUrl;
  String? linkdinUrl;
  String? education;
  int? experience;
  List<Roles>? roles;
  int? followers;
  int? following;
  int? totallands;
  int? yearExperience;
  int? monthExperience;
  int? minsalary;
  int? maxSalary;
  bool? isSalaryVissible;
  double? farmeasyRating;

  Result(
      {this.id,
      this.userId,
      this.userType,
      this.fullName,
      this.contactDetail,
      this.livesIn,
      this.bio,
      this.expertise,
      this.image,
      this.profileType,
      this.countryCode,
      this.mobile,
      this.instagramUrl,
      this.linkdinUrl,
      this.twitterUrl,
      this.facebookUrl,
      this.education,
      this.experience,
      this.roles,
      this.followers,
      this.following,
      this.totallands,
      this.maxSalary,
      this.isSalaryVissible,
      this.minsalary,
      this.monthExperience,
      this.farmeasyRating,
      this.yearExperience});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userType = json['user_type'];
    fullName = json['full_name'];
    contactDetail = json['contact_detail'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    livesIn = json['lives_in'];
    bio = json['bio'];
    yearExperience = json['experience_in_years'];
    monthExperience = json['experience_in_months'];
    minsalary = json['min_salary'];
    maxSalary = json['max_salary'];
    isSalaryVissible = json['is_salary_visible'];
    instagramUrl = json['instagram_url'];
    linkdinUrl = json['linkedin_url'];
    twitterUrl = json['twitter_url'];
    facebookUrl = json['facebook_url'];
    education = json['education'];
    experience = json['experience'];
    following = json['following'];
    followers = json['followers'];
    totallands = json['total_lands'];
    farmeasyRating = json['farmeasy_rating'];
    if (json['expertise'] != null) {
      expertise = <Expertise>[];
      json['expertise'].forEach((v) {
        expertise!.add(new Expertise.fromJson(v));
      });
    }
    image = json['image'];
    profileType = json['profile_type'];
    if (json['services'] != null) {
      roles = <Roles>[];
      json['services'].forEach((v) {
        roles!.add(new Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['full_name'] = this.fullName;
    data['contact_detail'] = this.contactDetail;
    data['lives_in'] = this.livesIn;
    data['bio'] = this.bio;
    data['twitter_url'] = this.twitterUrl;
    data['linkedin_url'] = this.linkdinUrl;
    data['facebook_url'] = this.facebookUrl;
    data['instagram_url'] = this.instagramUrl;
    data['farmeasy_rating'] = this.farmeasyRating;
    data['education'] = this.education;
    data['experience'] = this.experience;
    data['experience_in_years'] = this.yearExperience;
    data['experience_in_months'] = this.maxSalary;
    data['min_salary'] = this.minsalary;
    data['max_salary'] = this.maxSalary;
    data['is_salary_visible'] = this.isSalaryVissible;
    if (this.expertise != null) {
      data['expertise'] = this.expertise!.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    data['profile_type'] = this.profileType;
    if (this.roles != null) {
      data['services'] = this.roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Expertise {
  int? id;
  String? name;

  Expertise({this.id, this.name});

  Expertise.fromJson(Map<String, dynamic> json) {
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

class Roles {
  int? id;
  String? name;

  Roles({this.id, this.name});

  Roles.fromJson(Map<String, dynamic> json) {
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
