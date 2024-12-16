import 'package:farm_easy/Screens/Partners/Model/nearby_partner_view_mdoel.dart';

class UserDetailsResponseModel {
  String? detail;
  Result? result;

  UserDetailsResponseModel({this.detail, this.result});

  UserDetailsResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? countryCode;
  String? mobile;
  String? email;
  String? livesIn;
  String? bio;
  List<Expertise>? expertise;
  String? image;
  String? profileType;
  String? education;
  String? instagramUrl;
  String? facebookUrl;
  String? linkedinUrl;
  String? twitterUrl;
  int? followers;
  int? following;
  int? totalLands;
  bool? isFollowing;
  int? experienceInYears;
  int? experienceInMonths;
  int? minSalary;
  int? maxSalary;
  List<CropExpertise>? cropExpertise;
  bool? isSalaryVisible;
  List<Services>? services;
  double? farmeasyRating;

  Result(
      {this.id,
      this.userId,
      this.userType,
      this.fullName,
      this.countryCode,
      this.mobile,
      this.email,
      this.livesIn,
      this.bio,
      this.expertise,
      this.image,
      this.profileType,
      this.education,
      this.instagramUrl,
      this.facebookUrl,
      this.linkedinUrl,
      this.twitterUrl,
      this.followers,
      this.following,
      this.totalLands,
      this.isFollowing,
      this.experienceInYears,
      this.experienceInMonths,
      this.farmeasyRating,
      this.minSalary,
      this.maxSalary,
      this.cropExpertise,
      this.isSalaryVisible,
      this.services});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userType = json['user_type'];
    fullName = json['full_name'];
    countryCode = json['country_code'];
    mobile = json['mobile'];
    email = json['email'];
    livesIn = json['lives_in'];
    bio = json['bio'];
    if (json['expertise'] != null) {
      expertise = <Expertise>[];
      json['expertise'].forEach((v) {
        expertise!.add(new Expertise.fromJson(v));
      });
    }
    image = json['image'];
    profileType = json['profile_type'];
    education = json['education'];
    instagramUrl = json['instagram_url'];
    facebookUrl = json['facebook_url'];
    farmeasyRating = json['farmeasy_rating'];
    linkedinUrl = json['linkedin_url'];
    twitterUrl = json['twitter_url'];
    followers = json['followers'];
    following = json['following'];
    totalLands = json['total_lands'];
    isFollowing = json['is_following'];
    experienceInYears = json['experience_in_years'];
    experienceInMonths = json['experience_in_months'];
    minSalary = json['min_salary'];
    maxSalary = json['max_salary'];
    if (json['crop_expertise'] != null) {
      cropExpertise = <CropExpertise>[];
      json['crop_expertise'].forEach((v) {
        cropExpertise!.add(new CropExpertise.fromJson(v));
      });
    }
    isSalaryVisible = json['is_salary_visible'];
    if (json['services'] != null) {
      services = <Services>[];
      json['services'].forEach((v) {
        services!.add(new Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_type'] = this.userType;
    data['full_name'] = this.fullName;
    data['country_code'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['lives_in'] = this.livesIn;
    data['bio'] = this.bio;
    if (this.expertise != null) {
      data['expertise'] = this.expertise!.map((v) => v.toJson()).toList();
    }
    data['image'] = this.image;
    data['profile_type'] = this.profileType;
    data['education'] = this.education;
    data['instagram_url'] = this.instagramUrl;
    data['facebook_url'] = this.facebookUrl;
    data['linkedin_url'] = this.linkedinUrl;
    data['twitter_url'] = this.twitterUrl;
    data['followers'] = this.followers;
    data['following'] = this.following;
    data['farmeasy_rating'] = this.farmeasyRating;
    data['total_lands'] = this.totalLands;
    data['is_following'] = this.isFollowing;
    data['experience_in_years'] = this.experienceInYears;
    data['experience_in_months'] = this.experienceInMonths;
    data['min_salary'] = this.minSalary;
    data['max_salary'] = this.maxSalary;
    if (this.cropExpertise != null) {
      data['crop_expertise'] =
          this.cropExpertise!.map((v) => v.toJson()).toList();
    }
    data['is_salary_visible'] = this.isSalaryVisible;
    if (this.services != null) {
      data['services'] = this.services!.map((v) => v.toJson()).toList();
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

class CropExpertise {
  int? id;
  String? name;
  String? image;

  CropExpertise({this.id, this.name, this.image});

  CropExpertise.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    return data;
  }
}
