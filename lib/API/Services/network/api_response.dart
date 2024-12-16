import 'package:farm_easy/API/Services/network/status.dart';

class ApiResponse<T> {
  Status? status;
  T? data;
  String? message;
  ApiResponse(this.status, this.data, this.message);
  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.success(this.data) : status = Status.SUCCESS;
  ApiResponse.error(this.message) : status = Status.ERROR;
  @override
  String toString() {
    return "String: $status \n Message $message \n Data:$data";
  }
}
