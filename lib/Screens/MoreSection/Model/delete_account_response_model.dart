class DeleateAccountResponseModel {
  String? detail;
  String? result;

  DeleateAccountResponseModel({this.detail, this.result});

  DeleateAccountResponseModel.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
    result = json['result'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detail'] = this.detail;
    data['result'] = this.result;
    return data;
  }
}
