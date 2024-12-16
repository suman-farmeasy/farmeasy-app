abstract class BaseApiServices{
  Future<dynamic> getApi(String url,bool sendHeader,var headerMap);
  Future<dynamic> postApi(String url,dynamic data,bool sendHeader,var headerMap);

}