class ProductServiceListModel {
  String? detail;
  Result? result;

  ProductServiceListModel({this.detail, this.result});

  ProductServiceListModel.fromJson(Map<String, dynamic> json) {
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

  Result({this.data, this.pageInfo});

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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pageInfo != null) {
      data['page_info'] = this.pageInfo!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? description;
  List<Image>? image;
  String? currency;
  String? unitPrice;
  String? unit;
  String? unitValue;

  Data(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.currency,
      this.unitPrice,
      this.unit,
      this.unitValue});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    if (json['image'] != null) {
      image = <Image>[];
      json['image'].forEach((v) {
        image!.add(new Image.fromJson(v));
      });
    }
    currency = json['currency'];
    unitPrice = json['unit_price'];
    unit = json['unit'];
    unitValue = json['unit_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.image != null) {
      data['image'] = this.image!.map((v) => v.toJson()).toList();
    }
    data['currency'] = this.currency;
    data['unit_price'] = this.unitPrice;
    data['unit'] = this.unit;
    data['unit_value'] = this.unitValue;
    return data;
  }
}

class Image {
  int? id;
  String? image;

  Image({this.id, this.image});

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
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
