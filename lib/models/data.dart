abstract class Data<T>{}

class Success<T> extends Data<T>{
  bool isSuccessful = true;
  T data;
  Success({required this.data});
}

class Failure<T> extends Data<T>{
  String errorMessage;
  T? data;
  Failure({required this.errorMessage});
}