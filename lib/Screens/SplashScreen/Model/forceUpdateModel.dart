class ForceUpdateModel {
  String? detail;
  Result? result;

  ForceUpdateModel({this.detail, this.result});

  ForceUpdateModel.fromJson(Map<String, dynamic> json) {
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
  String? device;
  String? version;
  int? versionCode;
  bool? isRequired;

  Result({this.device, this.version, this.versionCode, this.isRequired});

  Result.fromJson(Map<String, dynamic> json) {
    device = json['device'];
    version = json['version'];
    versionCode = json['version_code'];
    isRequired = json['is_required'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device'] = this.device;
    data['version'] = this.version;
    data['version_code'] = this.versionCode;
    data['is_required'] = this.isRequired;
    return data;
  }
}
