class FertilizerCalculatedValueModel {
  String? detail;
  Result? result;

  FertilizerCalculatedValueModel({this.detail, this.result});

  FertilizerCalculatedValueModel.fromJson(Map<String, dynamic> json) {
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
  FertilizerRequirement? fertilizerRequirement;

  Result({this.fertilizerRequirement});

  Result.fromJson(Map<String, dynamic> json) {
    fertilizerRequirement = json['fertilizer_requirement'] != null
        ? new FertilizerRequirement.fromJson(json['fertilizer_requirement'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fertilizerRequirement != null) {
      data['fertilizer_requirement'] = this.fertilizerRequirement!.toJson();
    }
    return data;
  }
}

class FertilizerRequirement {
  Dap? dap;
  int? ureaRequirement;
  int? mopRequirement;
  int? sspRequirement;

  FertilizerRequirement(
      {this.dap,
      this.ureaRequirement,
      this.mopRequirement,
      this.sspRequirement});

  FertilizerRequirement.fromJson(Map<String, dynamic> json) {
    dap = json['dap'] != null ? new Dap.fromJson(json['dap']) : null;
    ureaRequirement = json['urea_requirement'];
    mopRequirement = json['mop_requirement'];
    sspRequirement = json['ssp_requirement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dap != null) {
      data['dap'] = this.dap!.toJson();
    }
    data['urea_requirement'] = this.ureaRequirement;
    data['mop_requirement'] = this.mopRequirement;
    data['ssp_requirement'] = this.sspRequirement;
    return data;
  }
}

class Dap {
  int? nitrogenRequirement;
  int? phosphorusRequirement;

  Dap({this.nitrogenRequirement, this.phosphorusRequirement});

  Dap.fromJson(Map<String, dynamic> json) {
    nitrogenRequirement = json['nitrogen_requirement'];
    phosphorusRequirement = json['phosphorus_requirement'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nitrogen_requirement'] = this.nitrogenRequirement;
    data['phosphorus_requirement'] = this.phosphorusRequirement;
    return data;
  }
}
