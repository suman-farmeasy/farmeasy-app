class AppException implements Exception{
  final _message;
  final _prefix;

  AppException([this._message,this._prefix]);
  String toString(){
    return '$_prefix$_message';
  }
}

class InternetExceptions extends AppException{

  InternetExceptions([String? message]):super(message,'No Internet');
}

class RequestTimeOut extends AppException{

  RequestTimeOut([String? message]):super(message,'Request Time Out');
}

class ServerExceptions extends AppException{

  ServerExceptions([String? message]):super(message,'Internal Server Error');
}

class InValidUrlException extends AppException{

  InValidUrlException([String? message]):super(message,'InValid Url');
}

class FetchDataException extends AppException{

  FetchDataException([String? message]):super(message,'InValid Url');
}