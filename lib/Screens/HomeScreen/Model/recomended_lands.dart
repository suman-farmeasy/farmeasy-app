class RecomendedLandResponseModel {
  String? detail;
  Result? result;

  RecomendedLandResponseModel({this.detail, this.result});

  RecomendedLandResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<RecommendedLands>? recommendedLands;
  int? count;

  Result({this.recommendedLands, this.count});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['recommended_lands'] != null) {
      recommendedLands = <RecommendedLands>[];
      json['recommended_lands'].forEach((v) {
        recommendedLands!.add(new RecommendedLands.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.recommendedLands != null) {
      data['recommended_lands'] =
          this.recommendedLands!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class RecommendedLands {
  int? id;
  int? landOwnerUserId;
  String? landOwnerUserType;
  String? landOwnerName;
  String? landOwnerImage;
  List<LandImages>? landImages;
  String? city;
  String? state;
  String? country;
  String? landSize;
  List<CropToGrow>? cropToGrow;
  CropToGrow? purpose;

  RecommendedLands(
      {this.id,
        this.landOwnerUserId,
        this.landOwnerUserType,
        this.landOwnerName,
        this.landOwnerImage,
        this.landImages,
        this.city,
        this.state,
        this.country,
        this.landSize,
        this.cropToGrow,
        this.purpose});

  RecommendedLands.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    landOwnerUserId = json['land_owner_user_id'];
    landOwnerUserType = json['land_owner_user_type'];
    landOwnerName = json['land_owner_name'];
    landOwnerImage = json['land_owner_image'];
    if (json['land_images'] != null) {
      landImages = <LandImages>[];
      json['land_images'].forEach((v) {
        landImages!.add(new LandImages.fromJson(v));
      });
    }
    city = json['city'];
    state = json['state'];
    country = json['country'];
    landSize = json['land_size'];
    if (json['crop_to_grow'] != null) {
      cropToGrow = <CropToGrow>[];
      json['crop_to_grow'].forEach((v) {
        cropToGrow!.add(new CropToGrow.fromJson(v));
      });
    }
    purpose = json['purpose'] != null
        ? new CropToGrow.fromJson(json['purpose'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['land_owner_user_id'] = this.landOwnerUserId;
    data['land_owner_user_type'] = this.landOwnerUserType;
    data['land_owner_name'] = this.landOwnerName;
    data['land_owner_image'] = this.landOwnerImage;
    if (this.landImages != null) {
      data['land_images'] = this.landImages!.map((v) => v.toJson()).toList();
    }
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['land_size'] = this.landSize;
    if (this.cropToGrow != null) {
      data['crop_to_grow'] = this.cropToGrow!.map((v) => v.toJson()).toList();
    }
    if (this.purpose != null) {
      data['purpose'] = this.purpose!.toJson();
    }
    return data;
  }
}

class LandImages {
  String? image;

  LandImages({this.image});

  LandImages.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

class CropToGrow {
  int? id;
  String? name;

  CropToGrow({this.id, this.name});

  CropToGrow.fromJson(Map<String, dynamic> json) {
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
