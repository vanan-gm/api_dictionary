import 'package:api_dictionary/commons/app_paths.dart';
import 'package:api_dictionary/models/data.dart';
import 'package:api_dictionary/models/word.dart';
import 'package:api_dictionary/repository/dictionary_repository.dart';
import 'package:dio/dio.dart';

class DictionaryRepositoryImpl extends DictionaryRepository{
  final Dio dio;
  DictionaryRepositoryImpl({required this.dio});

  @override
  Future<Data<Word>> getWord({required String searchWord}) async {
    final Response<dynamic> response = await dio.get('${AppPaths.endPoint}/$searchWord');
    if(response.statusCode == 200){
      return Success(data: Word.fromJson(response.data!.first));
    }else if(response.statusCode == 404){
      return Failure(errorMessage: response.data['message']);
    }else{
      return Failure(errorMessage: 'Something wrong happened');
    }
  }

}