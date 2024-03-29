import 'package:api_dictionary/commons/app_constants.dart';
import 'package:api_dictionary/commons/app_paths.dart';
import 'package:dio/dio.dart';

class DioHelper {
  Dio get dio => Dio()
    ..options.baseUrl = AppPaths.baseUrl
    ..options.connectTimeout = AppConstants.responseTimeout
    ..options.receiveTimeout = AppConstants.responseTimeout
    ..options.validateStatus = (code) => code! < 500;
}
