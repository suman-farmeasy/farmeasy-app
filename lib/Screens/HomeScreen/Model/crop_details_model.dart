class CropDetailsResponseModel {
  String? detail;
  List<Result>? result;

  CropDetailsResponseModel({this.detail, this.result});

  CropDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detail'] = this.detail;
    if (this.result != null) {
      data['result'] = this.result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? name;
  CropYield? cropYield;
  CostOfFarmingPerAcre? costOfFarmingPerAcre;
  CropYieldPerAcre? cropYieldPerAcre;

  Result(
      {this.name,
      this.cropYield,
      this.costOfFarmingPerAcre,
      this.cropYieldPerAcre});

  Result.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cropYield = json['crop_yield'] != null
        ? new CropYield.fromJson(json['crop_yield'])
        : null;
    costOfFarmingPerAcre = json['cost_of_farming_per_acre'] != null
        ? new CostOfFarmingPerAcre.fromJson(json['cost_of_farming_per_acre'])
        : null;
    cropYieldPerAcre = json['crop_yield_per_acre'] != null
        ? new CropYieldPerAcre.fromJson(json['crop_yield_per_acre'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.cropYield != null) {
      data['crop_yield'] = this.cropYield!.toJson();
    }
    if (this.costOfFarmingPerAcre != null) {
      data['cost_of_farming_per_acre'] = this.costOfFarmingPerAcre!.toJson();
    }
    if (this.cropYieldPerAcre != null) {
      data['crop_yield_per_acre'] = this.cropYieldPerAcre!.toJson();
    }
    return data;
  }
}

class CropYield {
  double? revenue;
  double? cost;
  double? netProfit;
  double? costPercentage;
  double? netProfitPercentage;

  CropYield(
      {this.revenue,
      this.cost,
      this.netProfit,
      this.costPercentage,
      this.netProfitPercentage});

  CropYield.fromJson(Map<String, dynamic> json) {
    revenue = json['revenue'];
    cost = json['cost'];
    netProfit = json['net_profit'];
    costPercentage = json['cost_percentage'];
    netProfitPercentage = json['net_profit_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['revenue'] = this.revenue;
    data['cost'] = this.cost;
    data['net_profit'] = this.netProfit;
    data['cost_percentage'] = this.costPercentage;
    data['net_profit_percentage'] = this.netProfitPercentage;
    return data;
  }
}

class CostOfFarmingPerAcre {
  int? seeds;
  int? fertiliser;
  int? pesticides;
  int? machinery;
  int? labour;
  int? landRent;
  int? supportMaterial;
  int? otherExpenses;
  int? total;

  CostOfFarmingPerAcre(
      {this.seeds,
      this.fertiliser,
      this.pesticides,
      this.machinery,
      this.labour,
      this.landRent,
      this.supportMaterial,
      this.otherExpenses,
      this.total});

  CostOfFarmingPerAcre.fromJson(Map<String, dynamic> json) {
    seeds = json['seeds'];
    fertiliser = json['fertiliser'];
    pesticides = json['pesticides'];
    machinery = json['machinery'];
    labour = json['labour'];
    landRent = json['land_rent'];
    supportMaterial = json['support_material'];
    otherExpenses = json['other_expenses'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['seeds'] = this.seeds;
    data['fertiliser'] = this.fertiliser;
    data['pesticides'] = this.pesticides;
    data['machinery'] = this.machinery;
    data['labour'] = this.labour;
    data['land_rent'] = this.landRent;
    data['support_material'] = this.supportMaterial;
    data['other_expenses'] = this.otherExpenses;
    data['total'] = this.total;
    return data;
  }
}

class CropYieldPerAcre {
  String? sowingSeason;
  String? harvestSeason;
  double? avgPrice;
  int? yieldInKg;
  int? cropValue;
  int? expenditure;
  int? netProfit;

  CropYieldPerAcre(
      {this.sowingSeason,
      this.harvestSeason,
      this.avgPrice,
      this.yieldInKg,
      this.cropValue,
      this.expenditure,
      this.netProfit});

  CropYieldPerAcre.fromJson(Map<String, dynamic> json) {
    sowingSeason = json['sowing_season'];
    harvestSeason = json['harvest_season'];
    avgPrice = json['avg_price'];
    yieldInKg = json['yield_in_kg'];
    cropValue = json['crop_value'];
    expenditure = json['expenditure'];
    netProfit = json['net_profit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sowing_season'] = this.sowingSeason;
    data['harvest_season'] = this.harvestSeason;
    data['avg_price'] = this.avgPrice;
    data['yield_in_kg'] = this.yieldInKg;
    data['crop_value'] = this.cropValue;
    data['expenditure'] = this.expenditure;
    data['net_profit'] = this.netProfit;
    return data;
  }
}
