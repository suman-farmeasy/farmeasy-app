class MarketPriceResponseModel {
  String? detail;
  List<Result>? result;

  MarketPriceResponseModel({this.detail, this.result});

  MarketPriceResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? state;
  String? district;
  String? market;
  String? commodity;
  String? variety;
  String? grade;
  String? arrivalDate;
  String? minPrice;
  String? maxPrice;
  String? modalPrice;

  Result(
      {this.state,
      this.district,
      this.market,
      this.commodity,
      this.variety,
      this.grade,
      this.arrivalDate,
      this.minPrice,
      this.maxPrice,
      this.modalPrice});

  Result.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    district = json['district'];
    market = json['market'];
    commodity = json['commodity'];
    variety = json['variety'];
    grade = json['grade'];
    arrivalDate = json['arrival_date'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    modalPrice = json['modal_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['district'] = this.district;
    data['market'] = this.market;
    data['commodity'] = this.commodity;
    data['variety'] = this.variety;
    data['grade'] = this.grade;
    data['arrival_date'] = this.arrivalDate;
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    data['modal_price'] = this.modalPrice;
    return data;
  }
}
