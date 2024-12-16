import 'dart:convert';
/// detail : "Operation Successful"
/// result : [{"id":4,"name":"Aeronautical Engineering"},{"id":15,"name":"Aviation Degree"},{"id":16,"name":"B.A"},{"id":44,"name":"B.A.M.S."},{"id":1,"name":"B.Arch"},{"id":17,"name":"B.Com"},{"id":18,"name":"B.Ed"},{"id":60,"name":"B.L"},{"id":19,"name":"B.M.M."},{"id":20,"name":"B.Phil"},{"id":2,"name":"B.Plan"},{"id":3,"name":"B.S. (Engineering)"},{"id":21,"name":"B.S.W"},{"id":22,"name":"B.Sc"},{"id":5,"name":"B.Sc IT/Computer Engineering"},{"id":55,"name":"B.Sc Nursing"},{"id":6,"name":"B.Tech"},{"id":34,"name":"BBA"},{"id":7,"name":"BCA"},{"id":45,"name":"BDS"},{"id":8,"name":"BE"},{"id":23,"name":"BFA"},{"id":35,"name":"BFM (Financial Management)"},{"id":24,"name":"BFT"},{"id":61,"name":"BGL"},{"id":37,"name":"BHA (Hospital Administration)"},{"id":36,"name":"BHM (Hotel Management)"},{"id":46,"name":"BHMS"},{"id":25,"name":"BLIS"},{"id":57,"name":"BPT"},{"id":56,"name":"BPharm"},{"id":48,"name":"BSMS"},{"id":47,"name":"BVSc"},{"id":65,"name":"CA"},{"id":66,"name":"CFA (Chartered Financial Analyst)"},{"id":67,"name":"CS"},{"id":69,"name":"DM"},{"id":50,"name":"DNB"},{"id":73,"name":"Diploma"},{"id":70,"name":"Fellow of National Board (FNB)"},{"id":76,"name":"High Secondary School/High School"},{"id":68,"name":"ICWA"},{"id":62,"name":"LL.B"},{"id":63,"name":"LL.M"},{"id":26,"name":"M.A"},{"id":9,"name":"M.Arch"},{"id":27,"name":"M.Com"},{"id":28,"name":"M.Ed."},{"id":64,"name":"M.L"},{"id":58,"name":"M.Pharm"},{"id":29,"name":"M.Phil"},{"id":10,"name":"M.S."},{"id":30,"name":"M.Sc"},{"id":11,"name":"M.Sc. IT/Computers Science"},{"id":12,"name":"M.Tech"},{"id":38,"name":"MBA"},{"id":49,"name":"MBBS"},{"id":51,"name":"MCh"},{"id":52,"name":"MD/MS (Medical)"},{"id":53,"name":"MDS"},{"id":13,"name":"ME"},{"id":31,"name":"MFA"},{"id":40,"name":"MFM (Financial Management)"},{"id":39,"name":"MHA/MHM (Hospital Administration)"},{"id":42,"name":"MHM (Hotel Management)"},{"id":41,"name":"MHRM (Human Resources Management)"},{"id":33,"name":"MLIS"},{"id":59,"name":"MPT"},{"id":32,"name":"MSW"},{"id":54,"name":"MVSc"},{"id":77,"name":"Others"},{"id":14,"name":"PGDCA"},{"id":43,"name":"PGDM"},{"id":71,"name":"Ph.D"},{"id":74,"name":"Polytechnic"},{"id":72,"name":"Postdoctoral fellow"},{"id":75,"name":"Trade School"}]

EducationListResponseModel educationListResponseModelFromJson(String str) => EducationListResponseModel.fromJson(json.decode(str));
String educationListResponseModelToJson(EducationListResponseModel data) => json.encode(data.toJson());
class EducationListResponseModel {
  EducationListResponseModel({
      String? detail, 
      List<Result>? result,}){
    _detail = detail;
    _result = result;
}

  EducationListResponseModel.fromJson(dynamic json) {
    _detail = json['detail'];
    if (json['result'] != null) {
      _result = [];
      json['result'].forEach((v) {
        _result?.add(Result.fromJson(v));
      });
    }
  }
  String? _detail;
  List<Result>? _result;
EducationListResponseModel copyWith({  String? detail,
  List<Result>? result,
}) => EducationListResponseModel(  detail: detail ?? _detail,
  result: result ?? _result,
);
  String? get detail => _detail;
  List<Result>? get result => _result;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['detail'] = _detail;
    if (_result != null) {
      map['result'] = _result?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 4
/// name : "Aeronautical Engineering"

Result resultFromJson(String str) => Result.fromJson(json.decode(str));
String resultToJson(Result data) => json.encode(data.toJson());
class Result {
  Result({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  Result.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;
Result copyWith({  num? id,
  String? name,
}) => Result(  id: id ?? _id,
  name: name ?? _name,
);
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}